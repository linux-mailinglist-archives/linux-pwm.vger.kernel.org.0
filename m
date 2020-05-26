Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9541E1DCB
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgEZJFT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 05:05:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14826 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgEZJFT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 05:05:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eccdb7c0000>; Tue, 26 May 2020 02:03:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 02:05:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 02:05:18 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 09:05:18 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 May 2020 09:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QutiWS/Ifiwda5toD8k4tRl0sTCSCdy0xHSScXtXiFOuj7A44fMmIXu0BsNl8AE0T8oPotw6R9qGWpK5Q53ovuWu0ciFzlL30LveaDJ+IePewptWbSuR0n+pcUu5vdpY2IU9504T2NFRAClkfUbmDJMo9deLgz95a5zcwkxbL3TtPD6+FF+CIGbmkYEHQe/l+5rd7rxmCySkp3TYvC3aDoam9DPd1oXmHel3ga2OWBra6lGOBCb5uus+VO+dQiom9fi8qh6t0ZWjnkIMDenvEfWi72T+a7SUzyyV0rUqea0iXlurLen6XwG1dwFn4pK5B5aKD/sXVbiYkyEHg5EBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNjBfjZ5habaVZ2Ia5kRqfTJG1x5mH333iRXKBpZqGU=;
 b=Tm0rjbaHT/gigGaBWlZ0e4z5fgvpzCQFnOao7AAXrQ6cbxYS1dybgrisFr9Foe7iG1VcqAFOuxkISk53AcnoJuhJCp2vrJbTzEZo1BfihgWXbgAkZTeZBcVNSHFg23q7Fg1okWNkdYkjEQzr8vV1zxwuVqH8jmyaAefZkgjo/ocoYB0IKG79EtvE44OYs38E/Qc4oeNkbsmZSO96CxiPsAR32mDGY/uVW55R/VHO8Vo0lcf5AfaI2AM7VidktnG5mfL+fcKsvrPTiFcCo1cbAC+/JJB2/Lni3CdMWjYoW34hyjXhDXv1FmdBio5+xDlvxqIUtx4YIv2ujy+X81qWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB3478.namprd12.prod.outlook.com (2603:10b6:a03:ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 09:05:16 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 09:05:16 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "kamil@wypas.org" <kamil@wypas.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Bibek Basu <bbasu@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Topic: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Index: AQHWMxtmVPDRpufQoUeveXztGYgnVKi58a4AgAAel4A=
Date:   Tue, 26 May 2020 09:05:16 +0000
Message-ID: <BYAPR12MB30140CD3D7C7263594FD4F30ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
 <20200526070450.sackolk6m3qv7omy@pengutronix.de>
In-Reply-To: <20200526070450.sackolk6m3qv7omy@pengutronix.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-05-26T09:05:12.7467718Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=f130ece4-eaef-4c7a-aa21-9f55a47f8c4e;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [124.123.74.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbdc271e-d2cd-4528-82b1-08d80153e881
x-ms-traffictypediagnostic: BYAPR12MB3478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34782FBEF362D04A268217CBADB00@BYAPR12MB3478.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDZZ4DrZDee5gadxDi5wqTLHSLl13E+E3KoUPibVAF1sLmhWndRBFTuPCp2axULDvNrdDkGxMevNNqObii2iGM/YJYY+uYmfrlWfELAugUjWhG7xeqEMOpWI8dMtRfPoEHCe/s/EMdr+X5weISDCqP7CGTToowJ25Kz3D5/mL8I/G3yr/CnhzFswBD3QTHQlF0NjKaYW6/KkTtnB7nvAdVFnxa5kbHx+10FPDs4SDFcFKg9tp1IJKJ7I8ym/AECwSCxn0MK5YsUCNvqP4KS1iDCxkktEYT2p/USJxM1873WAwuo1IcP2Dxwit60YF5DDBoF6gwHpyVDm421oHtsQfNL+ZW+zTBkONlNC9S0BeRzTRAs8o8mRI7kXDOOUYf0oSFuULvOaOpq7PhbckjroEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(7696005)(8936002)(26005)(76116006)(8676002)(2906002)(186003)(66946007)(66476007)(54906003)(71200400001)(53546011)(66556008)(966005)(66446008)(6506007)(478600001)(4326008)(64756008)(316002)(52536014)(66574014)(83080400001)(33656002)(9686003)(86362001)(7416002)(6916009)(55016002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TEsYVkXx9dHO7JBVkFOhWRCESaAt253LHn+Soc75hxQVRGD8QKZy03GsWnJoeWSV84BGuN8fEhV157OKVnPyTgCrU5HLiFreoDSbTZqvHG8VGf7v+hwBNQGyz/vskAS8e48bj/EsWF0wZi7X4py0RSh+k6Rxq8eYN47L99sqPjIU5K1H35CO03Du146uPo2e0/PqocL5nyNs/UZrR1o5BVTrDsqmCNc1b33zeKPPyEfyBe3/zA0NfPE1BVpWfRoh4pTEU9XZYDFfN+AXq55cPiyW0+Tpb2eSkViVgOOermbdzGmja3Sv2kFF3S+hQoDFKJOQltFwL/P/QnBN4/ZCeSwG1dZtjpe+hY7maM5rQ0B0inKorE3l0Dk7KLrgcNHKYiCTX5yek1Lje7fef//F7selwfc4CoxBU48QRWzp6duW42i8p1tVtaBFFIeZVIrWzSKjhkE9G3qhwzZ5tockhAY5OtWqHBP4kbQvlhaixo8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdc271e-d2cd-4528-82b1-08d80153e881
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 09:05:16.5581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/3su1c5Bm6Gfn3SOsyoaSnNy+0hd8URKd3r4jQGzt3mhK/9oQUNWo425FkGphzrSj65zv0sh4FRwYXasU6vxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3478
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590483836; bh=tNjBfjZ5habaVZ2Ia5kRqfTJG1x5mH333iRXKBpZqGU=;
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
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Gt4hJKm/2nYzQHm2Dbd1bNO0c3xKCinu4WkFSNXge51b7CCZwXEQPMZ/cHxwdccuI
         WeRkQXSLRxHC2viL3F/3cdCPNwzx7UFkisTYPFgTEICKy+YbOrXK1RWdveWXRcoc1h
         ieO0zYz1HJ+CETuMO9YfZ1til6zfM++LLuwkoI/SVZaykjkmUgD64lrEPa5ygB8Xvg
         Q6jGx0yEa82sYb8AnzYN5iiBz5pJnZruE7beHhNzfLK6vpcxbgCpRpc5xqvzzr/0Vj
         F+cw7gE7Mr508aOU869GQrKcgJNzOxhHPfvbfF3lkU5Xanc+EbY8T9y7vsOSyhPYA/
         SwpBiY+ILFdYw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Tuesday, May 26, 2020 12:35 PM
> To: Sandipan Patra <spatra@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>; Jonathan Hunter
> <jonathanh@nvidia.com>; kamil@wypas.org; jdelvare@suse.com; linux@roeck-
> us.net; robh+dt@kernel.org; Bibek Basu <bbasu@nvidia.com>; Bitan Biswas
> <bbiswas@nvidia.com>; linux-pwm@vger.kernel.org; linux-
> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remo=
ve
> module support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, May 26, 2020 at 10:36:04AM +0530, Sandipan Patra wrote:
> > This change has 2 parts:
> > 1. Add support for profiles mode settings.
> >     This allows different fan settings for trip point temp/hyst/pwm.
> >     T194 has multiple fan-profiles support.
> >
> > 2. Add pwm-fan remove support. This is essential since the config is
> >     tristate capable.
>=20
> These two are orthogonal, aren't they? So they belong in two patches.
>=20
> You have to expand the binding documentation.
>=20
> > Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> > ---
> >  drivers/hwmon/pwm-fan.c | 112
> > ++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 100 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> > 30b7b3e..26db589 100644
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
> > +             if (!base_profile) {
> > +                     dev_err(dev, "Wrong Data\n");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     if (base_profile) {
> > +             ctx->pwm_fan_profiles =3D
> > +                     of_get_available_child_count(base_profile);
> > +
> > +             if (ctx->pwm_fan_profiles <=3D 0) {
> > +                     dev_err(dev, "Profiles used but not defined\n");
> > +                     return -EINVAL;
> > +             }
> >
> > -     ret =3D of_property_count_u32_elems(np, "cooling-levels");
> > -     if (ret <=3D 0) {
> > -             dev_err(dev, "Wrong data!\n");
> > -             return ret ? : -EINVAL;
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
> > @@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device
> *pdev)
> >       return 0;
> >  }
> >
> > +static int pwm_fan_remove(struct platform_device *pdev) {
> > +     struct pwm_fan_ctx *ctx =3D platform_get_drvdata(pdev);
> > +     struct pwm_args args;
> > +
> > +     if (!ctx)
> > +             return -EINVAL;
> > +
> > +     if (IS_ENABLED(CONFIG_THERMAL))
> > +             thermal_cooling_device_unregister(ctx->cdev);
> > +
> > +     pwm_get_args(ctx->pwm, &args);
> > +     pwm_config(ctx->pwm, 0, args.period);
> > +     pwm_disable(ctx->pwm);
>=20
> What is what you really here? Is it only that the PWM stops oscillating, =
or is it
> crucial that the output goes to its inactive level?
>=20
> (The intended semantic of pwm_disable includes that the output goes low, =
but
> not all implementations enforce this.)
>=20
> Also please don't introduce new users of pwm_config() and pwm_disable() u=
se
> pwm_apply() instead.
>=20
> I wonder if this unregistration is "safe". When the driver is in use I'd =
expect that
> the hwmon device doesn't go away and so the devm unregistration callback =
that
> belongs to
> devm_hwmon_device_register_with_groups() blocks. But at this time the PWM
> is already stopped and so the device stops functioning earlier.
>=20
> Best regards
> Uwe
>=20

Thanks for reviewing the changes.

I see that pwm_fan_shutdown() which has got merged recently, can also be us=
ed for
module remove functionality. May be it will need a little bit of tweak in t=
he code.
However I should have not made both multiple profiles support and fan remov=
e functionality on
same patch.

For now I will prepare the current patch only to handle multiple profiles a=
nd corresponding
device tree settings.


Thanks & Regards,
Sandipan

> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
