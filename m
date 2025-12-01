Return-Path: <linux-pwm+bounces-7746-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1FC97F3C
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1194A3A3A83
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AFD1DED49;
	Mon,  1 Dec 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="G0LORUUR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010059.outbound.protection.outlook.com [52.101.229.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE21B87C0;
	Mon,  1 Dec 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601455; cv=fail; b=BOno9mW69qWZdrZjkaxc50bfJHCL5AwM6zD4G4jPXbB5L6Rwx2cLReGxjXaAOsHhvs0uwaFXwrsWFDQ/PCfe4EN9qvPZj1M1Kr3mEEve6rsHJZlEEmwlLaW5+nruOJpvIvEelYDp6j8mLOiH86Vfk/y/9lXaTVgBSMINBRysd4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601455; c=relaxed/simple;
	bh=A+fIVMsgDo+rfYiE5WgyRDVB/nljwQQCTR3lTVqc1Vs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDjH9VObHkt9dNaIVPZ9hX/SyKtV0nPCOhQf7bDdkepFb7hyD6EFrQVjrqm2fL3DZy6bZU551FrjXWedKt3HBZhg1zctS7KdG5qunBp0UNaxjv/NLlFNd/1hYESQ1GwVOFt67wxEOI1Bge0X0IXRQwTw0YmKYN6teUwLFirkoKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=G0LORUUR; arc=fail smtp.client-ip=52.101.229.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWE51L9IhmKNHGN6vaQw3/ToCjqwRbrPsV6agBfsPe7if1YOheFMWN1HcQju6iQpHePOt2JX2d/sfF6i5YVx862HKuWvKuR4osLWFrfdrxdkaLOUaILzRvKIFsmyqW5j9prmxOZmEYk/ykljdJUuxNu3MgEw3d8hlHYzLU0Gj1Xl3HLaS8h3iFtlI9YGwNDmUd59HnToHRfTQeqMn8SwIhdXanWnYoyazFInqxs1bJoqKbCcdc5VlXyzSJ7j/jJtPVEPyH5JSarbAxAX6yyG6jIVKGts5u/EJHRtdOH6PGi+ebOWJCp7d8SyaO+iNtz0hjgiBJMKItJSQhjc3aAQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtWcFNEqjvhIbobRJwycNfYEgk/k3VBX90758f9JDSw=;
 b=dKR9pQlPnOmQ7aJcBsQWh+q2qaQYrBl3UHBZ4i8oc9AhfJD8Xt3cfq/BC/WzpJsAC53yE1kBf9oeAmFz2yiZw+AAHpdVoHGu6xZEtm5bG3LXGlewAYUrfPgbBXvwOsUipwOI7lSwVM5bw04o/Mgs7Gh2CziAr8t5bB7zXbdLm+j5BCjapiozjuO9KZluMzQk1RI3GBE96+nD7ESY97rhaDnIMxCX+b7Nr4jZ7rl1JeG1fv/Prhn+gpBz7Txm6KVTM5A9hgbfYWiVY8NZi1zZ9Dmhuih9SNw22CCFsefbPNdbZ3Ns/Gt30f/+25/j9C3jm31iX8AXgmifq531axhR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtWcFNEqjvhIbobRJwycNfYEgk/k3VBX90758f9JDSw=;
 b=G0LORUURztqg7fex4L/W0kuoEtGK/L+XBqRkphc1DrddMFv7L7hJ9x/5St8K4Ygm2S8sHWTgGe6+YvA1JtQwNHuhO5twnufhBUHQTe8TAclqSyJVkeR1NT15HANGrsIpmvJKYL98JCSq3V+3L3uWX0jl3lN2ljUZq1XL1RCFUsc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY1PR01MB10833.jpnprd01.prod.outlook.com (2603:1096:400:31d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 15:04:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 15:04:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: biju.das.au <biju.das.au@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Topic: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Index: AQHcLJi5Wq0nvzczj0CSEUAgjJVVOrULUGQAgAG46lCAADdsgIAABTVAgAAHJmA=
Date: Mon, 1 Dec 2025 15:04:08 +0000
Message-ID:
 <TY3PR01MB113464F283A3ED4A8AAC813D886DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY1PR01MB10833:EE_
x-ms-office365-filtering-correlation-id: 44626cae-e7e0-4235-7e33-08de30eae104
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Z6UFFL4wUvffjK9555BVVFor26OkktyJOxZOylZzBN2SLoPSPIGc6K0LMc?=
 =?iso-8859-1?Q?bPEVBp91SMUInldukeyGEDGPYJJIH9P4cskfXtw1pzfjUtNjIP4PwGxqG4?=
 =?iso-8859-1?Q?aw32EfWK/K54s2AJpwrzhiYkzOkr02gG1MTXFOyJj3Zd2tOd5QR3JX1dCx?=
 =?iso-8859-1?Q?zno4wZKGulD9H3JccZpMnRY1sPf0VkDJwHiMwj4oqnDGx+D7abxkYpnuBR?=
 =?iso-8859-1?Q?DfwpcykMH3T0hgrP9zJW88FMn4G4zKY8L4mu8vuGT4Cj58O+qi0EsE1RJ9?=
 =?iso-8859-1?Q?w5IpUlNFSeESdQjG/7IN9WixbKmA6d9aizQSe7HgeZQOtfXDdunOR3v6Rb?=
 =?iso-8859-1?Q?edvmr/bRVRP1RExJkG85MkASKroDSmNP5Lrd1IHEdvhOHhZ5JQouukFX3/?=
 =?iso-8859-1?Q?UDwG1Sc2hkIAJc1sX5uEWTIPspDTovke4jtD6hJOqkHvR/t/TSg3OQ6tYv?=
 =?iso-8859-1?Q?1qF9I2587oxU9kfI5F8RjDTvAnSlJ2Fooe8sxeJDst4vmWsk4cL4ppTygw?=
 =?iso-8859-1?Q?rJCybdHBFAaBaudlQLjOv2GernUFF585BxAf8WF/0w2xIQbY5DY1T/0L5j?=
 =?iso-8859-1?Q?5jln3jeIz5U7bmZDqwAOXWcdyjIva0krsaezfyAw7KVyhXk7ZX0d1DsjpY?=
 =?iso-8859-1?Q?CKRmIKRn87tP7CPSlwSFCWKzaCySGGWb5NfloGkNtQy7b2bUQqw9P3MIir?=
 =?iso-8859-1?Q?nWQN6VLHz45gPht029r5/As2f/OmYVjVcFsbAFOpIlEGuDCYVvHJBYA2uS?=
 =?iso-8859-1?Q?ZqMNsRd/Nw8iaDVvnU/XhCCQKg+2dBBFKRqbwLCsoI97vvmkrGxiJAN+Jx?=
 =?iso-8859-1?Q?HHJFD7H3NwdWH2H7QiyU6kUhycArMoX/Xa9ax/dkqDNfCdze8VIzG9HC5V?=
 =?iso-8859-1?Q?dAIpm2lLhHYjEJyPm1uMUVTrXSOauFOXDGnZZ2rH1VEUuDOUeJEVJbufto?=
 =?iso-8859-1?Q?fOde8iQOV9VRVW9Y/PWDBKZAj4hFQm7zHdIdjA59PuFa6EiRDWzjaO9gxf?=
 =?iso-8859-1?Q?nO96PVAlrFwRCDkeUYQQJE0TcYEF7z59ANKIku4OzlVDZ0Di6qBu5+5dLp?=
 =?iso-8859-1?Q?NI1MIi7sRJYyHupXAGjCUifl8fRqx1KmyoHMdWED+DKVJXPKkvqQ1EoTPp?=
 =?iso-8859-1?Q?DnS5DP4DyVq0/egcDq3k5/Xfs0/QJa/b8x3PacxUWWKHNfQWDJs+qkwkjm?=
 =?iso-8859-1?Q?nNQDmiEltxaGu7Sh5yAdEYLI0QoEZ+IoMfUPmBV/zDdlinG/qg6bqWa2px?=
 =?iso-8859-1?Q?RAZNoo1gVT8YV2E9gWG+8ryboHBGOBmSTsy9089ToydIbv2DV3lVzAzZuj?=
 =?iso-8859-1?Q?pPkbFVPtoAx6UOCtBkip18zPXqVYzjC21gjtB5PnI6cacNSPhfBY6f6ppA?=
 =?iso-8859-1?Q?yim1gGQxv3zC/JHIe4sL3fsAgxSVbhCdloOhB7HLH5Me7SP1xWmbVIVp1u?=
 =?iso-8859-1?Q?RPqF0zE7ixePiAEu5z5P5Tp3B74re0csiWB+3Ukh/6b7kPMalRmkPchx1W?=
 =?iso-8859-1?Q?qlJwkGmwadPk5X3Wft5mpy6w46iZpddqoyaLZqzKLPnTlUqjF73bVN2vhu?=
 =?iso-8859-1?Q?oss89WUcn36d5ztLzB7vpClk0+3o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tLc0cf3t/y7hM58NNAjfAGRuOkvyg6gzEK0wDFlNyKxBi4RJb9aLr1iR8D?=
 =?iso-8859-1?Q?3tzilJUf+oaIcgDfQm7rp9Bh2TtFsqZ0HZTKR3Z/GaE4AS/CL+L5UmwvRf?=
 =?iso-8859-1?Q?Mkm2L59YfCS5NRJWljlev5qvkGDET16hFQRyKO8p2Ff1sf/fBYzTqFr8+I?=
 =?iso-8859-1?Q?l1SECxkEnlJMn3JlZfBaMYeGuxONch4ItYk0f0OHZzJr+3JUHxR3GElH21?=
 =?iso-8859-1?Q?+lhDlIDS56Q6cEEjjpj8V0OcNaDMBq/9ToDDiu1y/vV2JTf5lvwS8HuzUg?=
 =?iso-8859-1?Q?GIKyD7k+H0D7vfs3gBK3foL70yVov/q24jV/8EB66Dn3eXLHVNrpVQiQSW?=
 =?iso-8859-1?Q?3KfDcPxP883z+riSszMv7KC/buPTJnao8YECsxweFEgZ1PWUSfoITt7Jjl?=
 =?iso-8859-1?Q?JwBAN7FNMplxUjQ59xz9jkSvUiGCFOCHu1VK3MEAPoZfKky1rnNU/vTy/k?=
 =?iso-8859-1?Q?QyNsmOkFDb+6anO2IyQF+uPdJc5iliQm0IptDjK21r9+SbbzESf0iZ5VUH?=
 =?iso-8859-1?Q?9vkaJkye5PhuCpoexl7gfgFvYst1CKLeXs2VMhiKjp6KD/97taTuiZ5Ysf?=
 =?iso-8859-1?Q?O0kuMVgqmreGofwfN025w8HqSGLU6vh0MZ1fDtoeJGD81uMSEuB+estaaz?=
 =?iso-8859-1?Q?PXzjZP1KidgAcrW8c50I0ttbynxQY2QOFjVevRq1IByn8jtLjOUV2lLESg?=
 =?iso-8859-1?Q?Cwxyj5KKNqynP/JR33t+6SZYNMHW9HHMhcdCwi7p1m7sdqtjHuyPHONS06?=
 =?iso-8859-1?Q?DjD5kUZCi1AZAn/d7D0gqIwII2HbTzd11SWnkl1oxCmh3bQHwfRrp8QM3Y?=
 =?iso-8859-1?Q?nnYeGnrw8098wi3v6sDr5scKUWItTZ+vtkdWaRijIIms2iim+KGIs3Hk/h?=
 =?iso-8859-1?Q?81YWRTc80zzLq/3wucg9JSRdj9sikvfg01FnNp8X63wax+/SvMDZ0G1tWC?=
 =?iso-8859-1?Q?DVuAuvc/qOEdyDVVc4AEMn2hBc2uZqifVhB+FQ35+8gEQUMnBDh7hx35Nh?=
 =?iso-8859-1?Q?bjMk/9AulLnN2+Te/CazY62bpL+DG0WTbJEtjrZguBarpJZ+tlIMuGKZVE?=
 =?iso-8859-1?Q?m7wU3AUiJbHwS2y+pWDSV6uxZMfMMpRgf8iQwOx07uRjHSTy5CPHX3P47P?=
 =?iso-8859-1?Q?cO4q/BYyMhtAqSftBJehx0gOx1QcomzdyegTHiK3azUvrR+WP9AOvJgrJl?=
 =?iso-8859-1?Q?M3h7up/PhvdEnKN5dzili6M7Q7SHbOuzXv2pJUqcmQ15rmHKbMqvKQODaO?=
 =?iso-8859-1?Q?T8u4S3JIKNslwzTGiRNo26tTzVrRsyMimPCyittlVGvP8KSRCubm6DeE38?=
 =?iso-8859-1?Q?5tvdtmS4BqzCTnFtnoQioxo5k1ehUBD9Paa1ag91KSs11z5thn3c3fHXp5?=
 =?iso-8859-1?Q?seAk+Nu7DbJv2n2FFC7OKYeTGMXUBJXQa05k1AvvxrH0GSCPYqKRldOdpG?=
 =?iso-8859-1?Q?oImLMzAfKea4AL7W7QW6G7RWZFRKFx8eGYnfsEn13T9upBp8r03+98Cv5w?=
 =?iso-8859-1?Q?tJnL4aWck8YksxQDnNWyUphidrnd7wFzJgAJufOQWLDOhpPePZQJHtNPQV?=
 =?iso-8859-1?Q?LQewBl0HkL6oPOpWQVHp8Bd8rITyalJFte8FFfd/JDYQECbE7OCLtnW8Ln?=
 =?iso-8859-1?Q?GPuG4rMtFNkwFC4l16V72EoW+m5cA18UXejg4NR2WLoXX2jaKo3NQo6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44626cae-e7e0-4235-7e33-08de30eae104
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 15:04:08.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpV4zNHzbLccL+jZmD760JexJY7fwApcHCIREihgxNjxgBi1Y+v5jg0eAcqWQztIiHVt6964yhfqwQMpzvyv4cSiuYntiSM/HLYglKfOmYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10833

Hi Uwe,

> -----Original Message-----
> From: Biju Das
> Sent: 01 December 2025 14:43
> Subject: RE: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
>=20
> Hi Uwe,
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 01 December 2025 14:16
> > Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
> >
> > Hello Biju,
> >
> > On Mon, Dec 01, 2025 at 11:09:50AM +0000, Biju Das wrote:
> > > > -----Original Message-----
> > > > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > > > Sent: 30 November 2025 08:39
> > > > Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume
> > > > support
> > > >
> > > > On Tue, Sep 23, 2025 at 03:45:10PM +0100, Biju wrote:
> > > > > +static int rzg2l_gpt_suspend(struct device *dev) {
> > > > > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > > > > +		if (!rzg2l_gpt->channel_enable_count[i])
> > > > > +			continue;
> > > > > +
> > > > > +		rzg2l_gpt->hw_cache[i].gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2=
L_GTPR(i));
> > > > > +		rzg2l_gpt->hw_cache[i].gtccr[0] =3D rzg2l_gpt_read(rzg2l_gpt, =
RZG2L_GTCCR(i, 0));
> > > > > +		rzg2l_gpt->hw_cache[i].gtccr[1] =3D rzg2l_gpt_read(rzg2l_gpt, =
RZG2L_GTCCR(i, 1));
> > > > > +		rzg2l_gpt->hw_cache[i].gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2=
L_GTCR(i));
> > > > > +		rzg2l_gpt->hw_cache[i].gtior =3D rzg2l_gpt_read(rzg2l_gpt, RZG=
2L_GTIOR(i));
> > > > > +	}
> > > > > +
> > > > > +	clk_disable_unprepare(rzg2l_gpt->clk);
> > > > > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > > > > +	reset_control_assert(rzg2l_gpt->rst_s);
> > > > > +	reset_control_assert(rzg2l_gpt->rst);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int rzg2l_gpt_resume(struct device *dev) {
> > > > > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > > +	unsigned int i;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret =3D reset_control_deassert(rzg2l_gpt->rst);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret =3D reset_control_deassert(rzg2l_gpt->rst_s);
> > > > > +	if (ret)
> > > > > +		goto fail_reset;
> > > > > +
> > > > > +	ret =3D clk_prepare_enable(rzg2l_gpt->bus_clk);
> > > > > +	if (ret)
> > > > > +		goto fail_reset_all;
> > > > > +
> > > > > +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> > > > > +	if (ret)
> > > > > +		goto fail_bus_clk;
> > > > > +
> > > > > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > > > > +		if (!rzg2l_gpt->channel_enable_count[i])
> > > > > +			continue;
> > > > > +
> > > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[=
i].gtpr);
> > > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_ca=
che[i].gtccr[0]);
> > > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_ca=
che[i].gtccr[1]);
> > > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[=
i].gtcr);
> > > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache=
[i].gtior);
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +fail_bus_clk:
> > > > > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > > > > +fail_reset_all:
> > > > > +	reset_control_assert(rzg2l_gpt->rst_s);
> > > > > +fail_reset:
> > > > > +	reset_control_assert(rzg2l_gpt->rst);
> > > > > +	return ret;
> > > >
> > > > I wonder what happens if these calls in the error path fail. I
> > > > think the correct way would be to track the actual state to handle
> > > > the state on the next invokation for .resume() properly. But note
> > > > that suspend/resume is a somewhat blind spot for me, so I'm unsure =
here.
> > > > (And I'm aware that most resume callbacks don't cope cleanly
> > > > here.)
> > >
> > > In str case, there is no power on the system during suspend and exit
> > > is, SoC reset followed by restoring registers from DDR. So, it does n=
ot matter for the suspend
> path.
> > >
> > > In the resume case, If the calls to error path fail, then device won'=
t work.
> >
> > I'm not sure you understand my concern. IFAIUI a device that fails to
> > resume stays suspended from the POV of the kernel. When in this state
> > the resume is tried again at a later point in time you get
> > inconsistencies if the first reset was already deasserted from the
> > previous resume run (because
> > reset_control_assert() failed in the resume callback's error path).
>=20
> I have simulated a possible error condition in driver by adding a hack.
>=20
> Unlike probe(), .resume() never retries.
>=20
> For the first time: I got the pwm resume error [2] For the second time: I=
 got clk related warnings,
> but device enter into
> 			   suspend mode and on resume I got pwm resume error [3]

You mean to avoid unbalance between suspend()/resume(), we should not
do error handling in resume()??

We just keep accumulating error in ret variable and avoid register access i=
f there is error
and return error to the caller. In this way there is no unbalance across su=
spend()/resume()??
This way second trial may pass.

Cheers,
Biju


