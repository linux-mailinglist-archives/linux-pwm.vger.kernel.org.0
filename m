Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80CD1C3360
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2020 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEDHND (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 May 2020 03:13:03 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24417 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEDHNC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 4 May 2020 03:13:02 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafc0780000>; Mon, 04 May 2020 15:12:58 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 00:12:58 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 04 May 2020 00:12:58 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 07:12:56 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 4 May 2020 07:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/tn5UYhAmXD7e+T5qjZZfw6bZ/fGZTowLktVaSFPKMv6hkJvrLla2hF3NLVkeKreR7bxxeA78zQEOon5E5LM9ElWmyvq8QenzVdlHNjsXBk2O72dM9UlhfZqX5St/WPKo12fH7CfRCiA7r1s1KWlst4ln65sRIAd3rpcukrlj6MWmgEtIsQGdOXDxXOyWdaKwpe/rU3iEVUr1Cej3mrtg3gA31wlhg/t4WkHqxiIZXYMpPP4f4HPEWa+QJne8Dya+dytAwvZwO+9j0qddjDbF07sudvpmNOmWboPyeHcDgTalA52u4m9jD/3roVPplY5llzQYOUfkM8LLIFRRfbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kECTZCmd2XBE1SxGGjWgq0x8hjI9PUPtKCQT1MmjKrg=;
 b=GvFJdzxFf1nbOMR8yI7exOxwNaEapXBIFdX2l/tXCv1kDG0PxNHvvnoSo/yVPElXjG84TV3hfHMcFfZO+AvaIS84K3QP4SRaCSVT9R2fmN9OVgLTirYPnW1Zjl0ibFAhlQUH2ThKxUAwL/r4lGFdyc9QLoebkw7+pPEvDDsiWV+r7a7fndunNlURymEbVGs3JAdZ5mOnB0afP87bBc+Q4h/uuWRDf+/qhXL7idpux0Z8MTbhmA8/H7o46fw02GpVGJ/xa3KoRybT/6Rr1SKcYP2HieGVol2b9OtHJ6jejbxf8G04fnSnzXcnCNY8gCeq93QUHqOyWJsexLv3hsU5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB2598.namprd12.prod.outlook.com (2603:10b6:a03:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 07:12:53 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f%6]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 07:12:53 +0000
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
Subject: RE: [PATCH 1/2] arm64: tegra: Add pwm-fan profile settings
Thread-Topic: [PATCH 1/2] arm64: tegra: Add pwm-fan profile settings
Thread-Index: AQHWFLyrzrMCWV/QvUCwKZJpumRykaiXnTyQ
Date:   Mon, 4 May 2020 07:12:53 +0000
Message-ID: <BYAPR12MB3014C1C921052E96D30A92D5ADA60@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
In-Reply-To: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-05-04T07:12:49.5253634Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=5ec65c1b-095f-46a6-86e0-ba1d145efb65;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [124.123.72.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bc2fd76-a711-4fe2-bc76-08d7effa9038
x-ms-traffictypediagnostic: BYAPR12MB2598:|BYAPR12MB2598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB259851219D08AABB17CA0005ADA60@BYAPR12MB2598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:246;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtE42gsb8Nmqxw0TebpB0ms5yquC3O40po59aXQ3sWZrcERCLxrifSg6LDocXvnAjT7izy2a7oT+gQKkjJM6nJvqn6oofdVolykcbAgghGPKn+s39ANnswJKAEKe6/7yWqxQNNQou3CuyjtAiZsoJ4Big3qTFMHIB0XbWdYa/YwCpZAt8lSNbxXvi0a4kS7Kmhg5yXIMIirgXLTaf1SWVRjKFmFBCH1MciCH9oN9vDBq66MCKxBBflr574yKUntgGFtunYdOJmtZhbUCy1Xabb8xv8/A1cIyIrrow5zVFM693HypBnicoXoB2HemzUAdGXwYqlcq0++dLa1DzenCYIQbDKotNDs4pZswaoky1/WLhaScVKzX6d/vBpNnCZE0oIps8uP/8KaYxZohJHqaNItPxVscUBDUcriQw0kA0alIakdS45DqZpscZA2KlTJV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(346002)(396003)(39860400002)(52536014)(86362001)(54906003)(5660300002)(110136005)(316002)(8936002)(478600001)(8676002)(71200400001)(2906002)(33656002)(55016002)(53546011)(9686003)(66446008)(4326008)(76116006)(6506007)(26005)(66946007)(66476007)(186003)(6636002)(7696005)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VkNQI/d0u3I8NagOWL4BEdVXkRS8i9yhGaI6Q8fITH8VD54IvZGj84J4cAwShWbN6BxV+XiwJ2Nie9ZD2MKZFprH3kC47MdTjuSGrLK8p8lHr01h0+OCAbMnd4TsXDKALPzsE4WONC3jghbDM/9Aeus5igj9vacwUEQCbtGgmE4pdCTxsGT4EFT8FgERNSQd2MweW6KrfLboTq4YfSCWxju8/UjlW9b4H/w1Wdq52h+Xn9VKOigT5ZAhfP2BVxmNRvHaWlCyqv+UqpuOnF2DOQBPhAHZlHptYlIkSgTxZcvUWC6kSm44F7ktQ7GgUxbBOcl4RM14cxNZcoK/lvNMDwieQ1JXV9e2MTWqRfUDI0jX04/jk6KmABBmJCMzYHByp46r6H7v56MAPI6MKMG3PkTYqZA9FKgcsjFsLE/v7e52I2os4mZ754pU17XpUiilZTmF1b/O50PacKkuEOr8oiVJbEKI6M4q8cidzGMEqvJ3K2FHleeKLqGr4nz/0HRxwBpDLqIvR4Q9XDg+glLAQWwLfW0J614wpoCOdBz9gLH3eZR1qpnMV1FEbEzy0WnNFOHf+xpCDKxxQpbE1o0pSYUnJzmPqczrxnWSue9ExumoxoJOWFNRmHQ4F8EyywXVh0wuKPun5ZceljSBQaxMDDwulKMHO4eoLleldf5kVP0URf/zPGaF16F4wTHkEjWdCg151cfSFF56yCZ4+tLo8XcUpG+8VX4uHcfosmn5CChAVji44eWtMiek+2QP9FOvdL5u0t08RNeiI+J4zMXvw/i1HiN9OO/Onbz3anOFx2w=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc2fd76-a711-4fe2-bc76-08d7effa9038
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 07:12:53.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7Ea8KjVeosCX5tNXebrF3svLjqTV4A2BqJbbx9g4N0rlKpz90kUhvSl2gxQhkbRj07C0WXIS2y5QVFb/Xz7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588576378; bh=kECTZCmd2XBE1SxGGjWgq0x8hjI9PUPtKCQT1MmjKrg=;
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
        b=DEkAnYF+4VTYBLtwJQGSf/sA0Rhs9Urr/M9a6yn7izbh1AgjPQLqEswTB+GiKM4QJ
         fczkbWizDyBjbtiDVVGYfTKdafvryVUWoYwqhLWDjjeNmg0BIPlIqlGgn5riR2cBgc
         ZR6nc30Elhz/Fwhzss+I6JmS0zxrr7WADjeEjUMsD2eoBSHObxrmWnlYH9LjgLuCsa
         xtugm1Cr7bBUFi65qwWx0tC+4WB7QoLYxuqKFDz5U++LFHfAaa0PQhougOtXhN/9EI
         KadDEiNZzY0lcfHD2whD8tzDBOdxXUXzctMN1FSJBDGIF8qbC0DKmWGeW+3vVDBR5C
         ROZrYYAYjVSsA==
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
> Subject: [PATCH 1/2] arm64: tegra: Add pwm-fan profile settings
>=20
> Add support for profiles in device tree to allow different fan settings f=
or trip
> point temp/hyst/pwm.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index e15d1ea..ff2b980 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -219,10 +219,19 @@
>=20
>  	fan: fan {
>  		compatible =3D "pwm-fan";
> -		pwms =3D <&pwm4 0 45334>;
> -
> -		cooling-levels =3D <0 64 128 255>;
>  		#cooling-cells =3D <2>;
> +		pwms =3D <&pwm4 0 45334>;
> +		profiles {
> +			default =3D "quiet";
> +			quiet {
> +				state_cap =3D <4>;
> +				cooling-levels =3D <0 77 120 160 255 255 255 255
> 255 255>;
> +			};
> +			cool {
> +				state_cap =3D <4>;
> +				cooling-levels =3D <0 77 120 160 255 255 255 255
> 255 255>;
> +			};
> +		};
>  	};
>=20
>  	gpio-keys {
> --
> 2.7.4

