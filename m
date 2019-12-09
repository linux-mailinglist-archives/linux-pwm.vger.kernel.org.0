Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BAF11645F
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2019 01:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIAig (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Dec 2019 19:38:36 -0500
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfLIAig (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So7vfSdgsCGuVKzsndQ4+Ek/XsfVUXVqxRsndtTnu2JUcnmTS4FcWguIR0u/qafqq7z1tcopeAFDr8EaW7LyQD9eAWCa/MRhGYlFxL6ZPupdsYMHILF+m+ixQ2MhyT0UXrdbRjfFnTunn6afJVCRtBGMBw7DRKDqFC8L5Tkdl3wYh1fhW7tbwXEJwezbSTC6kAWRbdpqgYBnWA+i4w+f8wzAPU/+T+AH0ssNDZR472DVyWxAgPa8ERgrQKIXP7DMoOU5qtqKjKobZSjklMT2DEw0D6QoTvqvuPQmEvsBP+5DZyfLQIu7nN6sloAjIoIA7V1PGVrAEbu0IKadcvWMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXNcLcdAeo0vUEUlWi0HGg4M2K+x7XBsAsJblvUzQxU=;
 b=iMRzncD34dohEkn0nwA2ELk7a0n1dxx0Vg5L+ilt8TU5e1XoQhHVW5lpiPMo92HfK8gyBzS6vK7CBUlI7ulIHYp5S3iJOKZG+q/yiy1N03E3v8rd457V64BkYGovR41jwjKYSxOGIZQnQniTez5GGKtzwLiA5BSqtwyXemeY2aejoS3aH0EqwkG6W1G2KeQ9KX/YYPe0zEfSNtBRF+a9cWFVWlcEGGOYwpzmz7qKe6fBCueU7FYDzBNAEn9bWfkPuTUMdeE2Xj8uZ5viwVfds5NaGqlaIxtTYN6SZNB+CLzq0kY9t0gEQWrzFqHi0YmtwwCafz4nG8qKWkqGv/LdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXNcLcdAeo0vUEUlWi0HGg4M2K+x7XBsAsJblvUzQxU=;
 b=QDsHHFjx5K/kksKcNKLS5Nn32qo2wN9HPLqTBd4F9MbFWHD+EJJhbng++LH2lOOyxo8c+CO59WFR7B3IjYohXW+6YqfWUa/Z0n/HtZXbc1bV38buyEQh1fD1ZYC35TmDXeWHFUarwDl6OJq4AhypVVYySDxUi1Ts18Qy9oQV01o=
Received: from BN7PR08MB5042.namprd08.prod.outlook.com (20.176.177.14) by
 BN7PR08MB4402.namprd08.prod.outlook.com (52.132.223.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 00:38:31 +0000
Received: from BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1]) by BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 00:38:31 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 0/7] Add support for Azoteq IQS620A/621/622/624/625
Thread-Topic: [PATCH v2 0/7] Add support for Azoteq IQS620A/621/622/624/625
Thread-Index: AQHVrij6GhqbxcerYkmloeqT0s4QPw==
Date:   Mon, 9 Dec 2019 00:38:31 +0000
Message-ID: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To BN7PR08MB5042.namprd08.prod.outlook.com
 (2603:10b6:408:2c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a2d82e6-5a0f-4716-f0a9-08d77c401d4f
x-ms-traffictypediagnostic: BN7PR08MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB4402FB698BC941124605033BD3580@BN7PR08MB4402.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(34096005)(366004)(136003)(396003)(346002)(39830400003)(199004)(189003)(99286004)(71200400001)(52116002)(71190400001)(54906003)(4326008)(2906002)(6512007)(38610400001)(66556008)(66476007)(6486002)(66946007)(586005)(64756008)(66446008)(110136005)(107886003)(36756003)(8936002)(102836004)(50226002)(305945005)(2616005)(7416002)(5660300002)(6506007)(81166006)(81156014)(498600001)(26005)(86362001)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4402;H:BN7PR08MB5042.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Znvg1BwibvV6i2cY+w1n/N0Y6ZAPte3Yt4tyLXQ8Um5C8weOibUJQ8wwOHDUWoCPULeS+6fXEsTXFMYOq59QbcOsOhwG6kUzF0HozhMhX4g7ZDizT8iZPlNZWQG4lBetS4mSzSUdLiZ65wp0B829W1carqLifNJx8luaHEIfw645DnhnWAU2EvtToerxZaAekwnejCWMhhBSh0goE9UE1k8AcwThvle3j95rs7surOu0OXpw5ap5/CmHWV1ayhfEarpeuG1MBzuEOcCbfoec0Ej2XeV7BmQ6tNNKEbmSJF7WslJ8zR+wz5Sxonhk71zYt1DgJ6zaoFFoBcO3FK2odNrK2A0Ss/2okzVxFH4uS8jxIsIHqJvmyszrj/aflERLoseIjhuUa2n0v6c5F/MaQcNepO92kcx5AUXb0MxJ1LiKUwBWFMzkFvyitY1aV3jt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2d82e6-5a0f-4716-f0a9-08d77c401d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 00:38:31.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yy1NJ0Z5/t8ijHBBD0scFutVSm7Xxh2ZZ6UyIzYwf4LL9tt3XnWt8t7tPqLD9LPyeibHaRPs54VM2EXDzkE80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4402
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds support for the Azoteq IQS620A, IQS621, IQS622, IQS624 and
IQS625 multi-function sensors. Each device integrates numerous sensing tech=
-
nologies in a single package.

A multi-function device (MFD) driver supports core functions common to all
devices, including device identification, firmware, interrupt handling and
runtime power management. The MFD driver is also responsible for adding all
product-specific sub-devices.

Each device supports self-capacitive, Hall-effect, and (in some cases) mutu=
al-
inductive sensing. These functions represent keys or switches and are suppo=
rted
by an input driver that covers all five devices. An assortment of pwm and i=
io
drivers supports device-specific functions including ambient light and angu=
lar
position sensing.

This series was tested using the following development hardware: IQS620AEV0=
4,
IQS621EV04, IQS622EV04 and IQS624/5EV04.

Jeff LaBundy (7):
  dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
  mfd: Add support for Azoteq IQS620A/621/622/624/625
  input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
  pwm: Add support for Azoteq IQS620A PWM generator
  iio: temperature: Add support for Azoteq IQS620AT temperature sensor
  iio: light: Add support for Azoteq IQS621/622 ambient light sensors
  iio: position: Add support for Azoteq IQS624/625 angle sensors

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 ++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 ++++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/iqs621-als.c                     | 614 +++++++++++++++++=
+++
 drivers/iio/position/Kconfig                       |  19 +
 drivers/iio/position/Makefile                      |   7 +
 drivers/iio/position/iqs624-pos.c                  | 284 +++++++++
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/iqs620at-temp.c            |  97 ++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/iqs62x-keys.c               | 340 +++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/iqs62x-core.c                          | 639 +++++++++++++++++=
++++
 drivers/mfd/iqs62x-tables.c                        | 438 ++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-iqs620a.c                          | 206 +++++++
 include/linux/mfd/iqs62x.h                         | 146 +++++
 25 files changed, 3185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yam=
l
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 drivers/pwm/pwm-iqs620a.c
 create mode 100644 include/linux/mfd/iqs62x.h

--
2.7.4

