Return-Path: <linux-pwm+bounces-2663-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CA924810
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D25B24C33
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE31CE09D;
	Tue,  2 Jul 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="s+ZynAW4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2043.outbound.protection.outlook.com [40.107.114.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518521C8FBE;
	Tue,  2 Jul 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947986; cv=fail; b=WaGWWH6XC9td46IEg8ez64fVArELI4UED6d2cqZuppYvM4CWXjJ96aMZ8fbdwHf+OWrUHKVXAM+eWugv3JQAS19z4ggVJIMmB1K/T3jEfqzI2MViiIQYm3ZrXpeltAiLQhULKNEcCnqb8df3Mvjt/2MMs/wkVI31Bf/D6DAJvqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947986; c=relaxed/simple;
	bh=+f8jkY3omNGeaffim7bT9OukaRrPuSE0n+QrOTAtgSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5jJp8U2JICjJYfWjK5zNYc+u1f8urfQMBxON6ZxDOfknNISZe0vpr6bmB+0cZP+Il58sibnZtwhYtp6Zv9gDLED5cQ3sei0wVtm01FaoBObkhpB8tfbNJxTfKdI+BZrEfmiZuzXif/1OlKvMZFD2O0dPAbMI87xW0ZylK1lbXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=s+ZynAW4; arc=fail smtp.client-ip=40.107.114.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apCxYot2fb0lQxiGvgNU1y81o5VY5ilnk9ULsL0SJkAjjeP9lKwagk3S/zNc0jFqnH8IL98xvgd4gJlWhtN2mL4F7LWMS2kKOW/HWgxR5Z2s1TgV3mq+uk9xtOr3hRDffS5D91ydH3mx9KavkmHGzDyafxYcIhXs+NZRmjxXmi5ajilcOZFC6vyD2GD38720bvZIUEx8GKwlps2qzxqKmPFLsEVOlKedEOdGfwgDMSGDTHyZ04TIbXzhoaBT1tEnFLEw5zLu7sgt4t44SPvUuy9cj74eY0KGmYC9HNpC8FcXqympA41SY2+EQybyqNoaNjjEhnwuisaZFDX1+ZJl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSLbPoWvMtaTwq1dxfGZUvLN23pAqQ8gNH58EZN9Gzw=;
 b=DnA2UaGM0VRfCMyS/qVcxDdC5dJfRt89/oHADMgGYFk/g2bEzTV5OncCjcjV+JDfu9dJ3WOzei3hIUQD228flgDjagE8fI3GV0wUfILtGH079dBONmFnvdcrtguMqN0WrTERr8A7MshccHq/wHtRczr7lnuVzbIDIYRRt4LEnHV8k3U9C3L4GcVa8YQDz5GhcIy8gN136gVCyt96LBwU+3r/64QdAeMNwVWE8ErI9Y/xQMVe8OVVwR8DLgFbhcZpJ0xyaI3ACPNcpJ6Yd3yJ/EieiKAppZT7e8YqEOoxC5viMGOA7wZ6VhykP52ak7HbaxVGCRpGnK6M+29z9UrvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSLbPoWvMtaTwq1dxfGZUvLN23pAqQ8gNH58EZN9Gzw=;
 b=s+ZynAW4xaPixm9jPJT2QTI9xjBG8KZmIYw9KLGiQcVOSzqYIQujqAjIbeNEW81TaoC5jrlDrFwlW2SSeLlv6UKJyhPLysjWXO1mVfh1njYX/5j9Yg2gwkRpX8lRRll2FXSjfLi08Bpu4y+dndbcmh7lI3IG4xPXaSLvzVxPA+E=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSYPR01MB5304.jpnprd01.prod.outlook.com (2603:1096:604:80::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Tue, 2 Jul
 2024 19:19:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 19:19:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v20 0/4] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v20 0/4] Add support for RZ/G2L GPT
Thread-Index: AQHavnGE0/l3Iz4hM0yFu9pKYjv5C7Hj7IGg
Date: Tue, 2 Jul 2024 19:19:37 +0000
Message-ID:
 <TY3PR01MB11346DF196AE26F6C286058CE86DC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240614154242.419043-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240614154242.419043-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSYPR01MB5304:EE_
x-ms-office365-filtering-correlation-id: ec41a7c6-d823-4f82-f583-08dc9acbe9de
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rlfgrofWOZdhtmdz9lc731NPtBWTq9CTORtibo5Rdg4lBXfWafR5sv8R/3?=
 =?iso-8859-1?Q?6qpzD1jziWOqfi0bdwM2gQtR+PjvLUy8TqsrixVVMPA2moS6YW0WNHb0yo?=
 =?iso-8859-1?Q?dcJVUcg+mmAoY90C1mA6u4XFMb/VTEaQnxujPqSmF4r/v+R30lZVqI2ZNA?=
 =?iso-8859-1?Q?PZa+Bm4IcBXq94AGyoK5N2jszD6MJvf0Nza5fBDvWgZ+qr9JgDcU4eJ4zE?=
 =?iso-8859-1?Q?8oU5FwjCtSW1kO20GuMKHJDfY96c/jDgKpqNjkx32v63IEdnP/b9k3HTh0?=
 =?iso-8859-1?Q?SVhJCF0pxnGMiwPBHPs4/F6i6BZzAVuBzqAzpVGBfn8ObcMxK6xsXhCkxB?=
 =?iso-8859-1?Q?c23NE1dizYvfjR7pz+sr3lOyuqs3J+xt2B7f44v8bRHRRBx3kV+fyyLN9C?=
 =?iso-8859-1?Q?vwzO7s4MflOZSTtSCPPOz17u4ojImppNYZo1Hj47tBG88CqskAqub2rDX7?=
 =?iso-8859-1?Q?vWU+YOAzEvcZv+UYoHEB9SStJ0xF47QJtYqPiiibmXUPCLjVQre90NfuqF?=
 =?iso-8859-1?Q?sWenlDnfwEgECwq+gKJQJmjnAhYIauR/VHhq4Osm0IWt2qyG8QA6SJue0W?=
 =?iso-8859-1?Q?mDbMGk9eFFlEiVCYNNOjgB+/VxCS6V0MFRX6tJSMtP/JbFsc4IqwSO7KEd?=
 =?iso-8859-1?Q?1N9yN+9qSEiDMhulXvVEkQOC0D2iw/hz6+mzyxlGAJskbY+JZIoHHIPReI?=
 =?iso-8859-1?Q?LLVtsPf333LNGInzQcfwOUrT/1zzWIqrmvTZzwaLjXuE9vbVoQuYulAL+2?=
 =?iso-8859-1?Q?RV5pHfSfwZYJW1OgzmBTQMbAi/yD5UULGKHZbPsbh7utdGtKdi/j27FV8N?=
 =?iso-8859-1?Q?njQEUrkWADht8Pzn3vScNGJNa0C2tsAqBLAMqa7DMKhY92AE+BkTp2NvjW?=
 =?iso-8859-1?Q?rPMC+2h3E3TnwduRB8m22J2ACJrkx45aaGq5jlC/TFZN0vawSbhSpysIQB?=
 =?iso-8859-1?Q?n/1sQuTMJnVetN0JEhwTMTlTH0JKuDedAeFVH3oYonBKuIUXS1UcDaCLPI?=
 =?iso-8859-1?Q?Rl16mIlfIBiQzMjUMarAVyvDltTc2ec7sHlo+7acKqbbi7U39tK6YPPVvn?=
 =?iso-8859-1?Q?VAu/GSXv8bssbx+R4ZZHcb8hrOpG7FeMvDpnkoxnFcb9KP+iVLTQM5q3R0?=
 =?iso-8859-1?Q?N7Pne82bIE6fn70R4Y/k4V9ffr5ZTqSCrDp0rtxO7aVgvpOjISVd4v/SHx?=
 =?iso-8859-1?Q?zc9Rgi4WgjJsEItnUbZXTDj1BLQRH6bvoPqE9cMhgZXMkWK/vVcmPN0zVZ?=
 =?iso-8859-1?Q?BeFvPjr+R2jc5eQFl1CC4+1rngoHtjBNk6vaEadR6EnzEdQVNysH2WwiaV?=
 =?iso-8859-1?Q?e4xRkku/znXtLznsoO/MrWMFwtbbsuIBk4n1Bnnk8WRm2RKWmMlKHF8iw7?=
 =?iso-8859-1?Q?1yPDtQ2z5qsRkYZurLAIzQr3OcV2NNmVDn4q/7cEaKGmj1IzqpWnk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0r7cPehzzACXbNNWCtqBuJvBehz0mxV5STcUEtUsu8YhhR6j2SlOyS4jUU?=
 =?iso-8859-1?Q?rRvu0z0u8qJbAxttFWCqP5MxyOZ+/p1/v1mtcoxWK6V7wyUEZ0i1J9JUaj?=
 =?iso-8859-1?Q?equPH77sVKB98M51QAsEhqSymI2m4Qcgbeuna8e+SWbjaPgkWEDo5LyZJc?=
 =?iso-8859-1?Q?pqarZ3jGl3ZDB3F21eLCR796ZOwxUh3QWf31oG8VufETviHKSaGkafxe9t?=
 =?iso-8859-1?Q?adbqMlDzjs+r4mwMyGuZjqzq4VKLotA/WbzoHC1j+eqgAt61d7Jh3Sp1Az?=
 =?iso-8859-1?Q?OzbcsAQa05MDnP+JH9EUjK/gj0ekYj6lzUhw0c/N4WeccT+sDOte0vzQeL?=
 =?iso-8859-1?Q?zKa83yYELwxz5Ib3arZwT8g9Kor1JXtvFf6H7nz0twhWjPPgdO+EjRZ15N?=
 =?iso-8859-1?Q?M5LyZ+4EkIC65LuScg0y2frfTpju84ycOpeunj/nFVRrMU/Us4bJ6TVmyk?=
 =?iso-8859-1?Q?tQ82UPcfGzbLa3DzEAFVOjpV01TvDXDaB2X8DYDX7KFl4Qz3qMHwD4+N3x?=
 =?iso-8859-1?Q?Agju1Yg6SYyllKnBZimdrIMK+E0vbVorKeX6guWXnNdVOIy8m7h0aHMFtc?=
 =?iso-8859-1?Q?+rSHUiv2DL5qn5fd5SFsOFJbrtcEEB0VekSNvO4B31+r0r/c/mMOHIarYN?=
 =?iso-8859-1?Q?saMWPxx+nX4yU/emN140W8gjf1wR3M4DkNY/Wtm0PTxqPLNpzoy9b8kJnC?=
 =?iso-8859-1?Q?QQM8D8fmoToCkXgySGwqOIINwRDIlzJQoH+Rgu+Vqqd1y2GtCYRj41EhjG?=
 =?iso-8859-1?Q?RNocMGg7eifD+FDK45iSYNF9KtDdwLScvTlcBygUJXtuEx1bNsCyt7XkfY?=
 =?iso-8859-1?Q?9Ss9qQAsz32t9IJwL55+yy7qCfv8M9ItzPFiTGP2aRg6DXKLFml22rdgxQ?=
 =?iso-8859-1?Q?MbaepNsDLTGe1zfReuXvu+Uyg+43W2oJa0F+JDI/v2Bh3nNttlmPcLORD3?=
 =?iso-8859-1?Q?7qfk8yEr5UWCLomWt4j5W4Gx5ABX3LkDtYZnXdz3P4oOHUxyNC3yL8kGJx?=
 =?iso-8859-1?Q?cND7uGn5Dn/wmVd2qld+b3lJPo7H3ASZcWg48y/oZ3szpJDaqFfhu6CX8r?=
 =?iso-8859-1?Q?zvBXX2v7AHcjgeXSua6c7rrouN/O5vVmfN0qUsAB5DZ+cZsOZxEDIy02+x?=
 =?iso-8859-1?Q?f7HRXniINfk0lN05IrYGyF8r3P7BU87dqFatZSwyFpncX69meObxgHuRVJ?=
 =?iso-8859-1?Q?p6PIQMqWJxv8bHVmVj0HccUG4bTx7asFjm+MoVdNX8GcQ1yDCcxaZzgi3K?=
 =?iso-8859-1?Q?JvIqQldfJvm2j2FVTAYO21S+9SXQrlKH3C5yV0JnqpvsdO3Bnxn3T1D/Vd?=
 =?iso-8859-1?Q?hD3WIPE/rahsIlrpw5WRz6tp8jqltG8PF0OvOgjXQw9EjLUs+PV2w0ZrgJ?=
 =?iso-8859-1?Q?VHD9uJGEpzxejqoaA1YhAD0XnML1HBGMsZDD+G78Yo/U76dBA5F12YMTMq?=
 =?iso-8859-1?Q?Bxyd2qBhg8NJRHnG87Ewt7oPiytdbiS5O2ygFzFn6WzAtYxM9nBZaSRv3T?=
 =?iso-8859-1?Q?qVZA8yZOnu9et9CGO9Bl+t227NaJ/4F/GT3+N2LN+rqADdcVc9WG6zZYHG?=
 =?iso-8859-1?Q?cNfFcKyMBpsTNPFsw8iDjM/dLRt+VQ3VFvqz55M87CZbJyDx+eTWzHopKV?=
 =?iso-8859-1?Q?WySGmA1pUYdyhv8Uy08XkQnfiWyAHIREKY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec41a7c6-d823-4f82-f583-08dc9acbe9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 19:19:37.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC2W6ab0XURGNKa+4LUBtdPtXQFEMBjJZz4RwQ/zSbAhfo34GGDoIYD+1vJnzPArdDeq5/ZQW7JcCypo9hmd0VzaK078o1F3Dk8gOiaY8Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5304

Hi Uwe,

Gentle ping. Are you happy with this patch series?

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, June 14, 2024 4:43 PM
> Subject: [PATCH v20 0/4] Add support for RZ/G2L GPT
>=20
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer (=
GPT32E). It supports the
> following functions
>  * 32 bits x 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms=
.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> This patch series aims to add basic pwm support for RZ/G2L GPT driver by =
creating separate logical
> channels for each IOs.
>=20
> v19->v20:
>  * Added locks for rmw operations in rzg2l_gpt_{en,dis}able().
>  * Dropped decremeng enable_count based ch_en_bits in rzg2l_gpt_disable()=
.
>  * Added a comment in calculate_period_or_duty() related to overflow.
>  * Replaced ch_en_bits->bootloader_enabled_channels and used this variabl=
e
>    in probe(), apply() and remove() for simplification
>  * Replaced pm_runtime_enable()->devm_pm_runtime_enable()
> v18->v19:
>  * Replaced RZG2L_UP_COUNTING->RZG2L_GTUDDTYC_UP_COUNTING macro.
>  * Aligned RZG2L_GET_CH and RZG2L_GET_CH_OFFS macro
>  * Dropped chip and clk from struct rzg2l_gpt_chip as started using
>    devm_pwmchip_alloc() and devm_clk_rate_exclusive_get() to replace it.
>  * Replaced rate->rate_khz in struct rzg2l_gpt_chip and added a check in
>    probe() to make sure rate is multiple of 1000.
>  * Replaced container_of->pwmchip_get_drvdata() to get device data.
>  * Added a check in rzg2l_gpt_disable() not to decrement enable_count if
>    ch_en_bits is set by the probe.
>  * Dropped rzg2l_gpt_mul_u64_u64_div_u64()
>  * Simplified calculate_period_or_duty() using rate_khz
>  * Simplified rzg2l_gpt_config() using min macro for calculating period
>    and duty_cycle.
>  * Added checks in rzg2l_gpt_config() to prevent second channel setting
>    shared register.
>  * Updated error handling rzg2l_gpt_apply()
>  * Added local variable dev for &pdev->dev in probe()
>  * Added local varibles rate, chip and clk in probe()
>  * Dropped err_clk_rate_put label as started using
>    devm_clk_rate_exclusive_get()
>  * Replaced rzg2l_gpt->chip as data for devm_add_action_or_reset().
>  * Added error message for rate > 1GHz in probe.
> v17->v18:
>  * Added units.h for KILO macro.
>  * Replaced RZG2L_GTCCR{A,B}->RZG2L_GTCCR(i)
>  * Introduced macros RZG2L_GTIOR_{GTIOx,OxE} to handle subchannels.
>  * Replaced RZG2L_IS_IOB()->rzg2l_gpt_subchannel()
>  * Replaced the cache period->period_cycles.
>  * Updated rzg2l_gpt_is_ch_enabled() to return early if counter is not
>    running.
>  * Updated calculate_period_or_duty() for avoiding overflows.
>  * Updated rzg2l_gpt_calculate_pv_or_dc() with simplified calculation for
>    DIV64_U64_ROUND_UP() and dropped the cast for U32_MAX in min_t.
>  * Replaced mul_u64_u32_div->rzg2l_gpt_mul_u64_u64_div_u64() helper.
>  * Dropped pm pointer from struct rzg2l_gpt_driver() and simplified clk
>    handling in probe().
>  * Updated copyright from 2023->2024.
>  * Moved bitpos near to the user in patch#4.
> v16->v17:
>  * Added ret =3D dev_err_probe() to avoid return success in probe().
>  * Dropped unneeded MODULE_ALIAS().
>  * Dropped .owner from struct rzg2l_gpt_ops.
>  * Fixed build issue reported by kernel test robot <lkp@intel.com> by
>    replacing DIV_ROUND_UP()->DIV64_U64_ROUND_UP() in
>    rzg2l_gpt_calculate_pv_or_dc().
>  * Added max_val to struct rzg2l_gpt_chip to compute maximum period
>    supported by the HW in probe() and limit its value in apply() to
>    avoid 64-bit overflow with computation.
>  * Added helper function calculate_period_or_duty() to avoid losing
>    precision for smaller period/duty cycle values
>    ((2^32 * 10^9 << 2) < 2^64), by not processing the rounded values.
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div() as the former is
>    giving warnings with CONFIG_PWM_DEBUG enabled for very high values.
> v15->v16:
>  * Replaced the macro DIV_ROUND_UP_ULL->DIV64_U64_ROUND_UP
>  * Added DIV_ROUND_UP in rzg2l_gpt_calculate_pv_or_dc() to avoid loss of
>    precision.
>  * Replaced min->min_t() in rzg2l_gpt_calculate_pv_or_dc().
>  * Added a comment for rzg2l_gpt_config()
>  * Replaced mul_u64_u32_div()->mul_u64_u64_div_u64() in rzg2l_gpt_config(=
)
>  * Fixed the logical condition related to counter stop in
>    rzg2l_gpt_config().
>  * Dropped pm_runtime_resume_*() from rzg2l_gpt_config() as it is managed
>    by rzg2l_gpt_apply().
>  * Moved pm_runtime_resume_*() from rzg2l_gpt_{en,dis}able() to
>    rzg2l_gpt_apply().
> v14->v15:
>  * Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chip
>    based on feedback for pwm_mtu3 driver.
>  * Updated copyright header and commit description by replacing "This pat=
ch
>    adds"-> "Add"
>  * Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced ch_index-=
>ch
>    throughout
>  * rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
>    enable_count.
>  * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and propogated
>    the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
>  * Reduced variable scope in rzg2l_gpt_get_state() by moving most of
>    variables inside the if statement.
>  * Updated rzg2l_gpt_get_state() by moving duty > period check
>    inside the top if block.
>  * Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify confi=
g.
>    Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
>    min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
>  * Updated rzg2l_gpt_get_state() by moving duty > period check
>    inside the top if block.
>  * Simplified rzg2l_gpt_config() for updating registers
>  * Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
>    to make balanced PM usage count in rzg2l_gpt_reset_assert_pm_disable()
>    For case were unbind is called before apply where pwm is enabled by
>    bootloader.
>  * Added error check for clk_rate_exclusive_get() and clk_get_rate() in
>    probe().
>  * Dropped prescale from struct rzg2l_gpt_chip.
>  * Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in struc=
t
>    rzg2l_gpt_driver
>  * Updated commit description of patch#4 by replacing "This patch add"->
>    "Add".
> v13->v14:
>  * Moved the patch from series[1] to here.
>  [1] https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-
> biju.das.jz@bp.renesas.com/T/#t
>  * Add Rb tag from Rob for patch#2
>  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and RZG2L_CHANNELS_PER_I=
O
>  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added comme=
nt
>    for cache for prescale variable.
>  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
>  * Reordered rzg2l_gpt_config() just above apply()
>  * Replaced pwm_is_enabled()->pwm->state.enabled in config
>  * Replaced pm_runtime_resume_and_get with unconditional
>    pm_runtime_get_sync() in config().
>  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
>  * Added error check for clk_prepare_enable() in probe() and propagating
>    error to the caller for pm_runtime_resume()
>  * clk_get_rate() is called after enabling the clock and
>    clk_rate_exclusive_get()
>  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
>  * Added pm_runtime_idle() to suspend the device during probe.
>  * Moved overflow condition check from config->probe().
>  * Simplified rzg2l_gpt_reset_assert_pm_disable().
>  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
>  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it
>    not only parse the properties but also implements the needed register
>    writes.
>  * Added acomment here about the purpose of the function
>    rzg2l_gpt_poeg_init()
>  * Removed magic numbers from rzg2l_gpt_poeg_init()
>  * Fixed resource leak in rzg2l_gpt_poeg_init().
> v12->v13:
>  * Added test logs in [1] below
>  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
>  * Sorted #include <linux/limits.h> alphabetically
>  * Added a comment for mutex_lock to fix check patch warning
>  * Replaced data type of duty_cycle from unsigned int->u32 as
>    the maximum value stored is U32_MAX.
>  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related
>    code.
>  * Improved rzg2l_gpt_get_state() by setting
>   "val =3D rzg2l_gpt->duty_cycle[pwm->hwpwm];",  and factor
>   "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statement.
>  * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unused
>    from the callbacks.
> v11->v12:
>  * Added return code for get_state()
>  * Cache duty cycle/prescale as the driver cannot read the current duty
>    cycle/prescale from the hardware if the hardware is disabled. Cache th=
e
>    last programmed duty cycle/prescale value to return in that case.
>  * Updated rzg2l_gpt_enable to enable the clocks.
>  * Updated rzg2l_gpt_disable to disable the clocks.
>  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
>  * Updated rzg2l_gpt_get_state to use cached value of duty cycle/prescale=
,
>    If the PWM is disabled.
>  * Simplified rzg2l_gpt_apply()
>  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> v10->v11:
>  * Used bitmap_zero for initializing bitmap varable.
>  * Fixed clock imbalance during remove for the case bootloader turning
>    on PWM and module unload is called just after the boot.
>  * Fixed over flow condition in get_state() for a prescale value of
>    2 & more.
>  * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
>    only runtime variable.
>  * Added array for Cache variables state_period and prescale
>  * Probe caches the prescale value set by the bootloader.
>  * Updated rzg2l_gpt_config() to make use of array variables.
> v9->v10:
>  * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
>  * Keep Rb tag from Rob as the above change is trivial one.
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.
> v8->v9:
>  * Added Rb tag from Rob.
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Updated error handling in probe()
> v7->v8:
>  * Removed Rb tags from Rob and Geert as it modelled as single GPT
>    device handling multiple channels.
>  * Updated description
>  * Updated interrupts and interrupt-names properties
>  * Updated binding example
>  * Modelled as single PWM device handling multiple channels
>  * Replaced shared reset->devm_reset_control_get_exclusive()
>  * Added PM runtime callbacks
>  * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
>  * Replaced iowrite32->writel and ioread32->readl
>  * Updated prescale calculation
>  * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on both
>    IO's
>  * Moved enable/disable output pins from config->enable/disable.
>  * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
> v6->v7:
>  * Added the comment for cacheing rzg2l_gpt->state_period.
>  * Fixed boundary values for pv and dc.
>  * Added comment for modifying mode, prescaler, timer counter and buffer
>    enable registers.
>  * Fixed buffer overflow in get_state()
>  * Removed unnecessary assignment of state->period value in get_state().
>  * Fixed state->duty_cycle value in get_state().
>  * Added a limitation for disabling the channels, when both channels used
> v5->v6:
>  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
>    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
>    involving FIELD_PREP macro.
>  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
>    for duty_offset.
>  * replaced misnomer real_period->state_period.
>  * Added handling for values >=3D (1024 << 32) for both period
>    and duty cycle.
>  * Added comments for pwm {en,dis}abled by bootloader during probe.
> v4->v5:
>  * Added Hardware manual details
>  * Replaced the comment GTCNT->Counter
>  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
>    used in probe.
>  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
>  * Added driver prefix for the type name and the variable.
>  * Initialization of per_channel data moved from request->probe.
>  * Updated clr parameter for rzg2l_gpt_modify for Start count.
>  * Started using mutex and usage_count for handling shared
>    period and prescalar for the 2 channels.
>  * Updated the comment cycle->period.
>  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
>  * Replaced pc->rzg2l_gpt.
>  * Updated prescale calculation.
>  * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
>  * Removed platform_set_drvdata as it is unused
>  * Removed the variable pwm_enabled_by_bootloader
>  * Added dev_err_probe in various probe error path.
>  * Added an error message, if devm_pwmchip_add fails.
> v3->v4:
>  * Changed the local variable type i from u16->u8 and prescaled_period_
>    cycles from u64->u32 in calculate_prescale().
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
>  * Dropped the comma after the sentinel.
>  * Add a variable to track pwm enabled by bootloader and added comments
>    in probe().
>  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
>  * Replaced devm_clk_get()->devm_clk_get_prepared()
>  * Removed devm_clk_get_optional_enabled()
> v2->v3:
>  * Added Rb tag from Rob for the bindings.
>  * Updated limitation section
>  * Added prefix "RZG2L_" for all macros
>  * Modified prescale calculation
>  * Removed pwm_set_chip_data
>  * Updated comment related to modifying Mode and Prescaler
>  * Updated setting of prescale value in rzg2l_gpt_config()
>  * Removed else branch from rzg2l_gpt_get_state()
>  * removed the err label from rzg2l_gpt_apply()
>  * Added devm_clk_get_optional_enabled() to retain clk on status,
>    in case bootloader turns on the clk of pwm.
>  * Replaced devm_reset_control_get_exclusive->devm_reset_control_get_shar=
ed
>    as single reset shared between 8 channels.
> v1->v2:
>  * Added '|' after 'description:' to preserve formatting.
>  * Removed description for pwm_cells as it is common property.
>  * Changed the reg size in example from 0xa4->0x100
>  * Added Rb tag from Geert for bindings.
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested the driver with PWM_DEBUG enabled.
>=20
> RFC->v1:
>  * Added Description in binding patch
>  * Removed comments from reg and clock
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read() and updated macros
>  * Removed dtsi patches, will send it separately
>=20
> RFC:
>  * https://lore.kernel.org/linux-renesas-soc/20220430075915.5036-1-biju.d=
as.jz@bp.renesas.com/T/#t
>=20
> Biju Das (4):
>   dt-bindings: pwm: Add RZ/G2L GPT binding
>   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
>   pwm: Add support for RZ/G2L GPT
>   pwm: rzg2l-gpt: Add support for gpt linking with poeg
>=20
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 +++++++++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 637 ++++++++++++++++++
>  4 files changed, 1050 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-g=
pt.yaml
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
>=20
> base-commit: aa32efbe5b833a7a4d67294f32456563f328668c
> --
> 2.25.1


