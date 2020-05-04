Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380771C3370
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2020 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEDHPG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 May 2020 03:15:06 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:51160 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgEDHPG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 4 May 2020 03:15:06 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafc0f40000>; Mon, 04 May 2020 15:15:02 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 00:15:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 04 May 2020 00:15:02 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 07:14:59 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 4 May 2020 07:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCOw0onpD3F8cW+lXIxDwFO3vlxJgSiHJ0K0NJ6mK0mYvLVMqZABBL+mZ9ZKvoAJjfzuuZPEGoZtC5Tar6C2eaZ+t8TxDKJ0Jb0Cr+dwY/9gFSpAYslLhC8O6BtlD1evsQYzalQo0ZW+8o3V+VSLtA89hvegtHixDoysrevw6bzsVAkRwjPw51WqmgP1r0STRQCImRNrEr9EHfwgw6nfgrSgma9YpTBULM+9t8AqFtNZJKJOupwe9k/JuV8+9zMImL70+eANXYY7Z3GgUCLmCrNh59e6d9okCBNB/wvVRk1JHVHWMkBvUTG8aXk5rH8wkSMLvSPUPRzFUp0znRhBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlJPgtbjnDjt2uibZ6KgAnbmjSk602QMGEI6C24AeWU=;
 b=SfbzGtwCjM5OsK/tQe6XlVMjRt2mEM9yyKXiD0WZjelBL3QD1hK9OQx49L1XXd+n60bo90ZCbjDDh+sAc+0TdQFNHLKVdoXadFq0jbZ8TNrpC+nOBqX4lI7IrP5Clo+LaUjwwPNeATvvOogE4zm5y4AStRqJ4N06oMD0Je/pgErLBa3981sdIQExksypWPhSx81MAJkR19govw4Gr/Q/bRvvALpXw8YZn7+pbxmPHehoKYiQTxy37Evg6woioAmpTBuhykejsxUI6ca+jRST1VXFYuPwbqO0sxFPQ9KwFpk8GdMKPwaBIftpdh/Fm6b2bXTG3ihe40NGLg97iprLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB2598.namprd12.prod.outlook.com (2603:10b6:a03:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 07:14:57 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f%6]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 07:14:57 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Bibek Basu <bbasu@nvidia.com>, Bitan Biswas <bbiswas@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Topic: [PATCH 2/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Index: AQHWFLytoPJkFgnN1EGm1inu6qjNN6iXneEA
Date:   Mon, 4 May 2020 07:14:57 +0000
Message-ID: <BYAPR12MB3014895B534A8A0C559C8053ADA60@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
 <1587130362-6149-2-git-send-email-spatra@nvidia.com>
In-Reply-To: <1587130362-6149-2-git-send-email-spatra@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-05-04T07:14:54.5715664Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=5df521d7-4a34-4123-8685-2e0f3b240ca6;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [124.123.72.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3dc66c0-3602-48be-c8ed-08d7effada20
x-ms-traffictypediagnostic: BYAPR12MB2598:|BYAPR12MB2598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB259875FEFF3E5A28B7464F82ADA60@BYAPR12MB2598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcteQgH20+/O1C8sWq9qEhkHLbkFm0mCmid1oA0tYMth2m1D9DSqYUA4ieP1q5XAVN1t9d0zjPshpEnXm4fKiZu4uuohxMalRx9GljKrEeKpnkn5EVT2AeoQzrX+CSMA5QRSYNiT4ow/oNAo1hrM1GXhk7WOW6JJcG6/9/PPL9lsbQc4xHsRsqO4OMqeWBAhV7XLGwW3jg/64MFggX7NwbTkZanvKQj31rno0Qp2+icwyoM9QxVa018UfuBcnIHVT9aMqF1OadCEabe4T+1pNVduL2fJe1aFfW40soAFEfznanPk8246ur0pQwDAQm0ycG2oAATuce0nwUrVHkpDyLDtv85GV/sSekiaFYANwiYqjjzUrGslv6D7ZIGKkWKf/HtNZUWunldD6knUY2ahetDRsQrX42wIo7HH/WsrxzBAQfjfbIj7JbumjXVHDDjb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(53546011)(9686003)(55016002)(8676002)(71200400001)(33656002)(2906002)(7696005)(66476007)(66946007)(66556008)(64756008)(186003)(6636002)(66446008)(4326008)(76116006)(26005)(6506007)(54906003)(5660300002)(110136005)(316002)(52536014)(86362001)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Sux5HIyDioAGo7c5nbR0z8sq7x7f4IQTq/t7sy3D++63S5Zwx2Sa7IGkOyHpv1fhItupPtu4HoCgRX1/ysRf/GwD/O5nRKCzek6br1BSeVnr4oDSxMgwYFFjm9sYfC2g3FfEkLVWNsz3pIIGVyI6LFmLIwyGSQ48mzkjmfY6DGvM10+1EdecvSFWQ2yPG5TULBz35MnvNxiajsZw7vOFlaOHhCcm15HSxDSFMWYk9aTrRXZ5kd8bNUBk4gviVUMWN9+f7/YCZ1Uc8PbbuGJDkRE9rOkJ+aSxKjQybzM0KQDLFKBn700jitseYYnmiGPl/K0aUjHoOZCa2sKeTuh564W0k7DSQyoWveQXwW12PQRDaJ+T/+uVEHkh378iOM29g4DP5QmJCU7s9fZRfUkihX+Oz8tBcbDIFNPOoqMKTQcTIjSQs9/gNWscWG8mRItxOO5HKOeAM8Er4vJJ6JoKjuvo0nEVLo8VlNeslYYKZthZ9sBCQDVhNCk7693fgPUzjrKbNA0W3Jr0JC2iubGmPmbqEF3HFPZqNMz1i0zQESN40OJRx7KaY+M8enpnstkLvcOsSkLJDlS44mLI72zLibYTDIgdG7vx4sCfQsDq3teVPCjoTxVE9+SjVMQH3KORIByYPHTvUTr+K9IcnqiAcwxpPFDjovsNAHCpz/qcQRUEcdcQpCwRwdZRsZEm7919bFs3iw6WFfDdzU60EPAHecvUDDrs/mqDXlEv2NKb+tcwd7j7HurnSTyIzdIwJr7qEF/1uNdiNfGeVhe6IwLQWVXBYtSQRJj3cs8c6kJvv0c=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dc66c0-3602-48be-c8ed-08d7effada20
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 07:14:57.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKSFbIkjxxGqC2g6SKNkpVpkNiYNy0UuxYYuHIbtxgByuViGLDLaQ8Fe/lScVjamiqC1fCFxf69HXMFRtey/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588576502; bh=JlJPgtbjnDjt2uibZ6KgAnbmjSk602QMGEI6C24AeWU=;
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
        b=AIKGggmRqOkladoEeWqQhdDUBdYp61ikraIvUfMZydc+vsf3cJLmbSLF540Lzg6r0
         ID0mfnk9GkPLXYLf7n+P2tPevpFAb515eYwhgGS6JLYs0OsZkRxipzIYPdTboOL/wL
         tTsZzEr/0m38C8LqRi0gNi5Ai7E79L5nW1/WSJJBDamdFBx7KRa5MH0qPvfo1M4nbd
         /J0h05jHrsyg+vHyudXQZ5H6pcgYTOZJbYRcsX7TbQmmxMuAC+Mlm4a5AsjJcgs6qs
         2dUidOiDaqXC6LdweLmjWc+1vDjtv2g/sYHZIKs+E2GYtmcFLM9RQrXzzVZi/ap0Vj
         GWFrEKONlSKMQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Gentle reminder.

> -----Original Message-----
> From: Sandipan Patra <spatra@nvidia.com>
> Sent: Friday, April 17, 2020 7:03 PM
> To: Thierry Reding <treding@nvidia.com>; robh+dt@kernel.org; u.kleine-
> koenig@pengutronix.de; Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Bibek Basu <bbasu@nvidia.com>; Bitan Biswas <bbiswas@nvidia.com>;
> linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Sandipan Patra
> <spatra@nvidia.com>
> Subject: [PATCH 2/2] hwmon: pwm-fan: Add profile support and add remove
> module support
>=20
> This change has 2 parts:
> 1. Add support for profiles mode settings.
>     This allows different fan settings for trip point temp/hyst/pwm.
>     T194 has multiple fan-profiles support.
>=20
> 2. Add pwm-fan remove support. This is essential since the config is
>     tristate capable.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  drivers/hwmon/pwm-fan.c | 113
> +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 101 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> 30b7b3e..6332ed8 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -3,8 +3,10 @@
>   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2020, NVIDIA Corporation.
>   *
>   * Author: Kamil Debski <k.debski@samsung.com>
> + * Author: Sandipan Patra <spatra@nvidia.com>
>   */
>=20
>  #include <linux/hwmon.h>
> @@ -21,6 +23,8 @@
>  #include <linux/timer.h>
>=20
>  #define MAX_PWM 255
> +/* Based on OF max device tree node name length */
> +#define MAX_PROFILE_NAME_LENGTH	31
>=20
>  struct pwm_fan_ctx {
>  	struct mutex lock;
> @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
>  	unsigned int *pwm_fan_cooling_levels;
> +
> +	unsigned int pwm_fan_profiles;
> +	const char **fan_profile_names;
> +	unsigned int **fan_profile_cooling_levels;
> +	unsigned int fan_current_profile;
> +
>  	struct thermal_cooling_device *cdev;
>  };
>=20
> @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct
> device *dev,
>  				       struct pwm_fan_ctx *ctx)
>  {
>  	struct device_node *np =3D dev->of_node;
> +	struct device_node *base_profile =3D NULL;
> +	struct device_node *profile_np =3D NULL;
> +	const char *default_profile =3D NULL;
>  	int num, i, ret;
>=20
> -	if (!of_find_property(np, "cooling-levels", NULL))
> -		return 0;
> +	num =3D of_property_count_u32_elems(np, "cooling-levels");
> +	if (num <=3D 0) {
> +		base_profile =3D of_get_child_by_name(np, "profiles");
> +		if (!base_profile) {
> +			dev_err(dev, "Wrong Data\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (base_profile) {
> +		ctx->pwm_fan_profiles =3D
> +			of_get_available_child_count(base_profile);
> +
> +		if (ctx->pwm_fan_profiles <=3D 0) {
> +			dev_err(dev, "Profiles used but not defined\n");
> +			return -EINVAL;
> +		}
>=20
> -	ret =3D of_property_count_u32_elems(np, "cooling-levels");
> -	if (ret <=3D 0) {
> -		dev_err(dev, "Wrong data!\n");
> -		return ret ? : -EINVAL;
> +		ctx->fan_profile_names =3D devm_kzalloc(dev,
> +			sizeof(const char *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +		ctx->fan_profile_cooling_levels =3D devm_kzalloc(dev,
> +			sizeof(int *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +
> +		if (!ctx->fan_profile_names
> +				|| !ctx->fan_profile_cooling_levels)
> +			return -ENOMEM;
> +
> +		ctx->fan_current_profile =3D 0;
> +		i =3D 0;
> +		for_each_available_child_of_node(base_profile, profile_np) {
> +			num =3D of_property_count_u32_elems(profile_np,
> +							"cooling-levels");
> +			if (num <=3D 0) {
> +				dev_err(dev, "No data in cooling-levels inside
> profile node!\n");
> +				return -EINVAL;
> +			}
> +
> +			of_property_read_string(profile_np, "name",
> +						&ctx->fan_profile_names[i]);
> +			if (default_profile &&
> +				!strncmp(default_profile,
> +				ctx->fan_profile_names[i],
> +				MAX_PROFILE_NAME_LENGTH))
> +				ctx->fan_current_profile =3D i;
> +
> +			ctx->fan_profile_cooling_levels[i] =3D
> +				devm_kzalloc(dev, sizeof(int) * num,
> +							GFP_KERNEL);
> +			if (!ctx->fan_profile_cooling_levels[i])
> +				return -ENOMEM;
> +
> +			of_property_read_u32_array(profile_np, "cooling-
> levels",
> +				ctx->fan_profile_cooling_levels[i], num);
> +			i++;
> +		}
>  	}
>=20
> -	num =3D ret;
>  	ctx->pwm_fan_cooling_levels =3D devm_kcalloc(dev, num, sizeof(u32),
>  						   GFP_KERNEL);
>  	if (!ctx->pwm_fan_cooling_levels)
>  		return -ENOMEM;
>=20
> -	ret =3D of_property_read_u32_array(np, "cooling-levels",
> -					 ctx->pwm_fan_cooling_levels, num);
> -	if (ret) {
> -		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
> -		return ret;
> +	if (base_profile) {
> +		memcpy(ctx->pwm_fan_cooling_levels,
> +		  ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
> +						num);
> +	} else {
> +		ret =3D of_property_read_u32_array(np, "cooling-levels",
> +				ctx->pwm_fan_cooling_levels, num);
> +		if (ret) {
> +			dev_err(dev, "Property 'cooling-levels' cannot be
> read!\n");
> +			return -EINVAL;
> +		}
>  	}
>=20
>  	for (i =3D 0; i < num; i++) {
> @@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device
> *pdev)
>  	return 0;
>  }
>=20
> +static int pwm_fan_remove(struct platform_device *pdev) {
> +	struct pwm_fan_ctx *ctx =3D platform_get_drvdata(pdev);
> +	struct pwm_args args;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_THERMAL))
> +		thermal_cooling_device_unregister(ctx->cdev);
> +
> +	pwm_get_args(ctx->pwm, &args);
> +	pwm_config(ctx->pwm, 0, args.period);
> +	pwm_disable(ctx->pwm);
> +
> +	return 0;
> +}
> +
> +
>  static int pwm_fan_disable(struct device *dev)  {
>  	struct pwm_fan_ctx *ctx =3D dev_get_drvdata(dev); @@ -465,6 +552,7
> @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
>=20
>  static struct platform_driver pwm_fan_driver =3D {
>  	.probe		=3D pwm_fan_probe,
> +	.remove         =3D pwm_fan_remove,
>  	.shutdown	=3D pwm_fan_shutdown,
>  	.driver	=3D {
>  		.name		=3D "pwm-fan",
> @@ -476,6 +564,7 @@ static struct platform_driver pwm_fan_driver =3D {
> module_platform_driver(pwm_fan_driver);
>=20
>  MODULE_AUTHOR("Kamil Debski <k.debski@samsung.com>");
> +MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
>  MODULE_ALIAS("platform:pwm-fan");
>  MODULE_DESCRIPTION("PWM FAN driver");
>  MODULE_LICENSE("GPL");
> --
> 2.7.4

