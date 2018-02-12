import os, re

# Configurations
target = os.path.join('.', '..')
variables = {
  'proxy-domain': 'blockchain.example.com',
  'node-1': 'ec2-35-196-55-33.eu-central-1.compute.amazonaws.com'
}

# Loop files
def loop(cb, subdir=''):
  dir = os.path.join('.', subdir)

  for name in os.listdir(dir):
    file = os.path.join(dir, name)
    newsubdir = os.path.join(subdir, name)

    if name == 'build.py': continue
    if os.path.isdir(file): loop(cb, newsubdir)
    elif name.endswith('.template'): cb(subdir, name)


# Update file
def replacer(subdir, name):  
  print(f"Processing {name}")  
  dir  = os.path.join(target, subdir)
  file = os.path.join(dir, re.sub('\.template$', '', name))
  oldfile = os.path.join('.', subdir, name)

  with open(oldfile, "r") as fin:
    data = fin.read()

  for key, replacement in variables.items():
    data = re.sub(r"{{\s*" + key + r"\s*}}", replacement, data)

  if not os.path.exists(dir):
    os.makedirs(dir)

  with open(file, "w") as fout:
    fout.write(data)

# Start variable replacements.
loop(replacer)