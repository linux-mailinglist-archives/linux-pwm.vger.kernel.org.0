Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB6144A68
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2020 04:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAVD2d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 22:28:33 -0500
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:36538
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728900AbgAVD2d (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 21 Jan 2020 22:28:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsxcXoyf31a2WGdx4WMc78tfL6g/0lGOKjr9DD52CKjGlRVz0kVtGb00ZPBMUkeKjwyH4hjLNtMYAUB3MvT4LkF5ROhBFRdgcNannoCklO6h2ku5YrsNLgCD/huAC8C1YQLvH5zmpNRkFIH+FYMrdh4U5iFOQnclt4luMYFiboiOZjsiArt7O4ZXS1AgUqRWP3HZAEaZnAcxjiJZ1YvcL8afEpx9F5I2U+MO8nhTM3ZufvPm6SaWVCsYD3IQHBSi8fCpgl2LhQAklBJ58JVrJ/r/KxQAzMj+Vj0LRUa4MRMGdxDSS4HjFpY7ukTW9MsRhXso5mczmcKvDlVEQoCJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEgS5jEzqTJAQvq0cLtSFPK4RZrG3otBfDCxfCOuNoQ=;
 b=oVpQ2H+rw5lW5Z7SVJf09KeI1bLHDLh9AR2Y2bukAkYyH9uFNBQyjYGdnevwp7yOwUynoJgv2NphoIc4He2hQFj5G5n7drseVrMz2MYkxa3wiaAfKDUq+ZgUXPLD3Ex1ESI2mKCTE02AdKOhSCpof4Ame36xTqX8nSSJ2opK4cau6l9xI7XJqypC8voS+kHMkfe7yN1wcRaTD6ajo5umSs+3uYmLWWFeDeLG3z626N0Zp5eYMHGXDXwFQPsRV9yWt9tmqNJBJRdtaDDaeuskGAG/OgIeiVsXkm8ldSPWfuhGSEAHQZKzUGBuQdzFMqwY68t1EYfQGlisIqwFxqX0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEgS5jEzqTJAQvq0cLtSFPK4RZrG3otBfDCxfCOuNoQ=;
 b=jsYOO1aHIrydPzWBVql/p7/k76GI9phZm80qc+UhVwrbpsfko7DZAF3INv2H390//EtZYe8peLyEtCTtdlCDkc0L78piB8iH5oyzb/1O8Gi8srFG7uZolq5KKc/zjBGe3djvLXTm2gKuBKylC24zFyuK/ewphrgCKve+f5gqMLE=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4416.namprd08.prod.outlook.com (52.135.73.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 03:28:29 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.026; Wed, 22 Jan 2020
 03:28:28 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0401CA0004.namprd04.prod.outlook.com (2603:10b6:803:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 22 Jan 2020 03:28:27 +0000
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
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Topic: [PATCH v4 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Index: AQHVzN7fAr6PI6irWkKW3LyZYxsVRaf2Dj+A
Date:   Wed, 22 Jan 2020 03:28:28 +0000
Message-ID: <20200122032821.GA29969@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-6-git-send-email-jeff@labundy.com>
In-Reply-To: <1579228475-6681-6-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0004.namprd04.prod.outlook.com
 (2603:10b6:803:21::14) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6d60c07-9f90-4923-f3e3-08d79eeb2587
x-ms-traffictypediagnostic: SN6PR08MB4416:
x-microsoft-antispam-prvs: <SN6PR08MB44167E839F8C904FA42BB8BBD30C0@SN6PR08MB4416.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:276;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39830400003)(376002)(189003)(199004)(52116002)(7696005)(71200400001)(8886007)(508600001)(66476007)(36756003)(5660300002)(110136005)(66946007)(7416002)(2616005)(54906003)(4326008)(1076003)(26005)(16526019)(55016002)(186003)(33656002)(81166006)(2906002)(86362001)(66446008)(66556008)(64756008)(8936002)(8676002)(81156014)(956004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4416;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWraZ8W/vyjJNR1Q9ZjgmwqJRMRUIfu/+v0ZyEjhbvQpIgHKHA1TkN9cOVuoOPqRPl8lRKFVLrMyfVDl0StZBLVEXM1KxU2u9GLzQ6NLuTPBPVfRHE/NPGXqG2MN66NCAg4xGo5lkBKOH5jOMV/uh+OjkgOwacSxAf19jNcBOH0rVZo7T7B3YwYm0PHvEhYG7HsFQjfkpv5z4LrrjWQxghKvRssKnj2G+gw5jSv6xQ2wE8u15Q84CyS1EGopNjaffCKBFuNOrWqWUPhYg3LYs6UUaqWcr0QKxU3q6qLr6OaXdZLCKCqqjGgPQSxSZKXH8ZZZ1SXkuje0k0A5rdXCdBoLkskOmSuTS/TuYvoT8496ip3GICluYhzqXSXYE7awvLw0Vsz0R/owjtusfn4yENUEv4xekAnOQAHB3XXgNcJq53YNgcotwARLrIKJeqJP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F2C989C4E0F6B46B9CC1A0A730BEEE0@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d60c07-9f90-4923-f3e3-08d79eeb2587
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 03:28:28.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvADmCCgDn41a1x1VW+DsyxoK36t3Vqcr8YS1+/44IkPS1Q+gLzCtfRM9D2Jo4ADKbFHWJPsL1vHDfJJls8hyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4416
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jonathan,

I just wanted to give a heads up that I'm making a couple of very minor
changes to the lot of IIO patches in this series in response to changes
to include/linux/mfd/iqs62x.h for v5, namely:

- Replaced iqs62x->map with iqs62x->regmap
- Dropped #defines for platform_driver name and alias in favor of the
  actual string names (e.g. IQS620_DRV_NAME_TEMP --> "iqs620at-temp")

For small changes like these, I plan to retain your Reviewed-by trailer
when I send out v5 even though the file would have changed slightly. If
you would prefer I let you re-review first, please let me know.

On Thu, Jan 16, 2020 at 08:36:08PM -0600, Jeff LaBundy wrote:
> This patch adds support for the Azoteq IQS620AT temperature sensor,
> capable of reporting its absolute die temperature.
>=20
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes in v4:
>   - None
>=20
> Changes in v3:
>   - Added Reviewed-by trailer
>=20
> Changes in v2:
>   - Moved the driver from hwmon to iio
>   - Merged 'Copyright' and 'Author' lines into one in introductory commen=
ts
>   - Replaced 'error' with 'ret' throughout
>   - Eliminated tabbed alignment of platform_driver struct members
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
>=20
>  drivers/iio/temperature/Kconfig         | 10 ++++
>  drivers/iio/temperature/Makefile        |  1 +
>  drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 drivers/iio/temperature/iqs620at-temp.c
>=20

Kind regards,
Jeff LaBundy
