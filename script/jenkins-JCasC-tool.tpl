tool:
  git:
    installations:
    - home: "git"
      name: "Default"
  mavenGlobalConfig:
    globalSettingsProvider: "standard"
    settingsProvider: "standard"
  sonarRunnerInstallation:
    installations:
    - name: "SonarScanner"
      properties:
      - installSource:
          installers:
          - sonarRunnerInstaller:
              id: "4.7.0.2747"