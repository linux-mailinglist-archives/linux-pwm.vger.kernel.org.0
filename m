Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2618218612
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgGHL1u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 07:27:50 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:12440 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGHL1t (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Jul 2020 07:27:49 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05adb20000>; Wed, 08 Jul 2020 19:27:46 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 04:27:46 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 08 Jul 2020 04:27:46 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 11:27:46 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 8 Jul 2020 11:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Js9EH83N5yRkCDDNW23qIcGwbc6ptYA6xygNZRR1YXKJXfKrz16MF60ChaTEY7Cxq91f2iLF14IGG9Da6NyC1zIGSdSx3+WKK8Jz3e3mQSULUjDYddOmzazevurgabx0+93QhfsBAbHrxvyd/Wj6XAfNsar7L2IlbtbPld25QWw3zGVc7Rf/NGK0FCUQxvWe8YQr/82nXPXhC8YZQw+sLwZGpumiaCm1MkaNJlPhOuRE35z388ECfny3fntvGi+BSXsQQqOkadfF+JQVtAmAPgsB6MCHI/ezvboXU63rQR4JgWXtZmLd0cgFFEsNOL2vv3At66ao+p5oeSZdSKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFdDXPqgYhppjhlPyAm7a3BuHpJGzp4q+4h4lonktys=;
 b=ILCbB8x1Rw/AKg+E9lpPBFoj7SiNoUhZSDMDZoZ3jbhB4dqOOYLewVC15hEOIaa3e+IZ2MgcSzI++4dKfTizI7f6vegc6qBIUq1vmTmFF1W4owAtUIuKy12ddh6polPKS3wE3w9OKjSTYz0tC/12FVLz2DmktIByxtybF6J4LCilSqouv/ufc3zY2U1ASLp4cFIwH+5aa3DPuvh59o/K3YikYXnoqGrAE8EI00z7w7gI2Y0l6CFu+PWoCYK478l++sqfQVeNAVUHgqD5hIlohb71BjL0PKeF3aGEl+yRK4rWlt0V1uDCekYnxLz43n2seYW0KQXhi4NfVQNDBZbZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BY5PR12MB3858.namprd12.prod.outlook.com (2603:10b6:a03:1a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 11:27:43 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6%7]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 11:27:43 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "kamil@wypas.org" <kamil@wypas.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Bibek Basu <bbasu@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Topic: [PATCH V2 1/2] hwmon: pwm-fan: Add profile support and add
 remove module support
Thread-Index: AQHWN9ycKHlYqjjfNk67F84qF8AHKajFZF6AgDhefqA=
Date:   Wed, 8 Jul 2020 11:27:43 +0000
Message-ID: <BYAPR12MB30148BCF84846172616AF0C9AD670@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
 <20200602142813.GA54592@roeck-us.net>
In-Reply-To: <20200602142813.GA54592@roeck-us.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-08T11:27:40.5829045Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=31d9f051-e4f4-4b8d-b545-5b4b07e881dd;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [115.114.90.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a897ad90-4814-4245-8928-08d82331ee4d
x-ms-traffictypediagnostic: BY5PR12MB3858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3858595FB02D9F55905D2F6AAD670@BY5PR12MB3858.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jmzX1aDSbIMpUjl0BlwZXFdEdvL75kqD5GzFGhA2AdwFB25AbmP/rLE65vlmrYSZKkJyN4uZNpoTe3Tqky3F//9yiLDAGUGRbKONr/X4Q64zlpcRgWPQRNoQIyP8zHCz7mSDJnhLaWSKYDHH/Siu3p4dlybrAJj7xzQhtxmEHSJSlQeRs/o7CJWNUYLvwpcDH/K2/K3oe5TcWw+33OM9N1rVvENiKS3L/0UP84EBGLIpTgMNcGSgOqeh4P1D6lK8gHSNeXG6mNnLfpIfakIFJezoUMckwFEkTSPPSBajvabwhQ5Nt4v57skrgyNBYu7NsQs+DTgiuFKK0K0FfmbniA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(316002)(5660300002)(7696005)(9686003)(26005)(53546011)(54906003)(2906002)(186003)(55236004)(6506007)(71200400001)(8936002)(86362001)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(52536014)(7416002)(8676002)(4326008)(55016002)(6916009)(83380400001)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D8vf4Rxlp+P6H5dhE0D36B86BZcsLJflLU0inxEUFVcmkq4IZfsv9XGxq0FmhStavf7eYujzimWgmuB0Sgn7iz6du1BMdS1tc47yLTtwFut4m3h08qtuTa3SuoES3sEc6GKENX74hyXyWyDQC1sh9UcCxv8utx29ok4sr8K6uAy5WVOZF9RnRDdzRVldRa58YtSv4XySkhPftTctupGrLYLnC9lBQ6KC5M6ayVHLv6z1YAYBG9KQS3UNxbYyKophTjUpAmFMMvAamztVQb0kWgr8qw/5Vl/Amx3SmYu2ZprBrefmUOvTY0rbN1d8UwAfk9orTQRk6Lq0vnxklROK4uF4r6uCDcBN/bOaGnpONhKyGVYqrhm4gOVuSfMiQRVr4AMM9w7VZpCBmkwhFWBPNdQZgZin3MixU9+xJ5CoE3kPj8/t0Rm5RqSJ4p34TXPemjGl6mKIc73uScbtmuuz6EOpz9+7z5tuJvn16pg84hw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3014.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a897ad90-4814-4245-8928-08d82331ee4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 11:27:43.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ObWUWC0z04X97XtWn352K2vky+kWJC3v5sjwlLHxeZ92DKLyGIvvFmKEoJWx9wJChxQxPpuOJblabmqUAu+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3858
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594207666; bh=lFdDXPqgYhppjhlPyAm7a3BuHpJGzp4q+4h4lonktys=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=rTCE9y42jSFpRJkmbYf7uXgz1ZrdTkvIMpR0aLKHmGKeZfiT6dRPv0dbIS0GZDYYm
         OyVwp2AO1SxcE7EHSTdRDonhbWnItp77uwI6jkPxPMITQyPBuBF0FTjs5TCHqm7LrJ
         41uJScXb+NyNK2tV9BDUjA4+cXoNbUIEYVj9OIFpXRFHNcS+VQ17VMpyp31SV1zh7r
         PwNy4/zqlh+qamQtGiZyiFdBAnLlA7MbOx8UQ/R5cmceQakr0EfKlNnojUOnEMQQ6x
         M5A9rUdZqrAfgPBiDdMOnX0qWzHlroHpAtoNE0yOJFtG9/v+arqT3LG+MiPGD7PWAn
         IvPEUiNO5+7rg==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Guenter,

Agreed with the suggestion with regards to fan profile support.
Looked at thermal driver and further planning to implement required changes=
 in thermal core instead of pwm-fan driver.
Dropping the current series.=20


Thanks & Regards,
Sandipan

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Tuesday, June 2, 2020 7:58 PM
> To: Sandipan Patra <spatra@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>; Jonathan Hunter
> <jonathanh@nvidia.com>; kamil@wypas.org; jdelvare@suse.com;
> robh+dt@kernel.org; u.kleine-koenig@pengutronix.de; Bibek Basu
> <bbasu@nvidia.com>; Bitan Biswas <bbiswas@nvidia.com>; Krishna Yarlagadda
> <kyarlagadda@nvidia.com>; linux-pwm@vger.kernel.org; linux-
> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V2 1/2] hwmon: pwm-fan: Add profile support and add
> remove module support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, Jun 01, 2020 at 11:49:13AM +0530, Sandipan Patra wrote:
> > Add support for profiles mode settings.
> > This allows different fan settings for trip point temp/hyst/pwm.
> > Tegra194 has multiple fan-profiles support.
> >
> > Signed-off-by: Sandipan Patra <spatra@nvidia.com>
>=20
> The subject says "remove module support". What is this supposed to be abo=
ut ?
>=20
> The code adds support for multiple cooling "profiles" but, unless I am re=
ally
> missing something, no means to actually select a profile.
> This adds a lot of complexity to the code with zero value.
>=20
> Either case, and I may have mentioned this before, functionality like thi=
s should
> really reside in the thermal core and not in individual drivers.
>=20
> > ---
> >
> > PATCH V2:
> >       Cleaned pwm_fan_remove support as it is not required.
> >
> >  drivers/hwmon/pwm-fan.c | 92
> > ++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 80 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> > 30b7b3e..1d2a416 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -3,8 +3,10 @@
> >   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
> >   *
> >   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > + * Copyright (c) 2020, NVIDIA Corporation.
> >   *
> >   * Author: Kamil Debski <k.debski@samsung.com>
> > + * Author: Sandipan Patra <spatra@nvidia.com>
>=20
> You can not claim authorship for a driver by adding a few lines of code t=
o it.
>=20
> >   */
> >
> >  #include <linux/hwmon.h>
> > @@ -21,6 +23,8 @@
> >  #include <linux/timer.h>
> >
> >  #define MAX_PWM 255
> > +/* Based on OF max device tree node name length */
> > +#define MAX_PROFILE_NAME_LENGTH      31
> >
> >  struct pwm_fan_ctx {
> >       struct mutex lock;
> > @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
> >       unsigned int pwm_fan_state;
> >       unsigned int pwm_fan_max_state;
> >       unsigned int *pwm_fan_cooling_levels;
> > +
> > +     unsigned int pwm_fan_profiles;
> > +     const char **fan_profile_names;
> > +     unsigned int **fan_profile_cooling_levels;
> > +     unsigned int fan_current_profile;
> > +
> >       struct thermal_cooling_device *cdev;  };
> >
> > @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct
> device *dev,
> >                                      struct pwm_fan_ctx *ctx)  {
> >       struct device_node *np =3D dev->of_node;
> > +     struct device_node *base_profile =3D NULL;
> > +     struct device_node *profile_np =3D NULL;
> > +     const char *default_profile =3D NULL;
> >       int num, i, ret;
> >
> > -     if (!of_find_property(np, "cooling-levels", NULL))
> > -             return 0;
> > +     num =3D of_property_count_u32_elems(np, "cooling-levels");
> > +     if (num <=3D 0) {
> > +             base_profile =3D of_get_child_by_name(np, "profiles");
>=20
> You can not just add new properties like this without documenting it and =
getting
> approval by devicetree maintainers.
>=20
> Guenter
>=20
> > +             if (!base_profile) {
> > +                     dev_err(dev, "Wrong Data\n");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     if (base_profile) {
> > +             ctx->pwm_fan_profiles =3D
> > +                     of_get_available_child_count(base_profile);
> >
> > -     ret =3D of_property_count_u32_elems(np, "cooling-levels");
> > -     if (ret <=3D 0) {
> > -             dev_err(dev, "Wrong data!\n");
> > -             return ret ? : -EINVAL;
> > +             if (ctx->pwm_fan_profiles <=3D 0) {
> > +                     dev_err(dev, "Profiles used but not defined\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ctx->fan_profile_names =3D devm_kzalloc(dev,
> > +                     sizeof(const char *) * ctx->pwm_fan_profiles,
> > +                                                     GFP_KERNEL);
> > +             ctx->fan_profile_cooling_levels =3D devm_kzalloc(dev,
> > +                     sizeof(int *) * ctx->pwm_fan_profiles,
> > +                                                     GFP_KERNEL);
> > +
> > +             if (!ctx->fan_profile_names
> > +                             || !ctx->fan_profile_cooling_levels)
> > +                     return -ENOMEM;
> > +
> > +             ctx->fan_current_profile =3D 0;
> > +             i =3D 0;
> > +             for_each_available_child_of_node(base_profile, profile_np=
) {
> > +                     num =3D of_property_count_u32_elems(profile_np,
> > +                                                     "cooling-levels")=
;
> > +                     if (num <=3D 0) {
> > +                             dev_err(dev, "No data in cooling-levels i=
nside profile
> node!\n");
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     of_property_read_string(profile_np, "name",
> > +                                             &ctx->fan_profile_names[i=
]);
> > +                     if (default_profile &&
> > +                             !strncmp(default_profile,
> > +                             ctx->fan_profile_names[i],
> > +                             MAX_PROFILE_NAME_LENGTH))
> > +                             ctx->fan_current_profile =3D i;
> > +
> > +                     ctx->fan_profile_cooling_levels[i] =3D
> > +                             devm_kzalloc(dev, sizeof(int) * num,
> > +                                                     GFP_KERNEL);
> > +                     if (!ctx->fan_profile_cooling_levels[i])
> > +                             return -ENOMEM;
> > +
> > +                     of_property_read_u32_array(profile_np, "cooling-l=
evels",
> > +                             ctx->fan_profile_cooling_levels[i], num);
> > +                     i++;
> > +             }
> >       }
> >
> > -     num =3D ret;
> >       ctx->pwm_fan_cooling_levels =3D devm_kcalloc(dev, num, sizeof(u32=
),
> >                                                  GFP_KERNEL);
> >       if (!ctx->pwm_fan_cooling_levels)
> >               return -ENOMEM;
> >
> > -     ret =3D of_property_read_u32_array(np, "cooling-levels",
> > -                                      ctx->pwm_fan_cooling_levels, num=
);
> > -     if (ret) {
> > -             dev_err(dev, "Property 'cooling-levels' cannot be read!\n=
");
> > -             return ret;
> > +     if (base_profile) {
> > +             memcpy(ctx->pwm_fan_cooling_levels,
> > +               ctx->fan_profile_cooling_levels[ctx->fan_current_profil=
e],
> > +                                             num);
> > +     } else {
> > +             ret =3D of_property_read_u32_array(np, "cooling-levels",
> > +                             ctx->pwm_fan_cooling_levels, num);
> > +             if (ret) {
> > +                     dev_err(dev, "Property 'cooling-levels' cannot be=
 read!\n");
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       for (i =3D 0; i < num; i++) {
