Return-Path: <linux-pwm+bounces-7729-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F927C91AFA
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 11:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE151344D34
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3D30BBB6;
	Fri, 28 Nov 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QyKKISS0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011058.outbound.protection.outlook.com [40.107.74.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B49AD2C;
	Fri, 28 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326253; cv=fail; b=TAtWKtoQX6MEAGjircdNw4Uid+vgGeLm3LWLqIo0J52ieGelbsVln2lINoFnNycVQlp2BOfa/twFjFHJ5vq2sgnNYk0mgzW2yYqifn9mRa3j9+lKAEUd2etRV70wP2Rpx8vimbHiHwrlvqu0r/cYIf2cChQFL8OM/mckjmQYYJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326253; c=relaxed/simple;
	bh=zCVCFTOk4TUXfubP+6eZExq4l5U8X2WbWL0M5aM2gH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doTYirLQxRyLwptuRSjiUybt7sY+9u517VUTWH9TDwVqvLpSj/J45Hvtyzfh4CuZf4Gr9mR6ZWCkwdAVQwT+blyLtpDdG5a+pGwt6u+mr4SOIefNvQaruFqoJxGOUMypM+flis+UR8UWWreGxIx2v+1RXheKQw4Ab82Uq5Tp3xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QyKKISS0; arc=fail smtp.client-ip=40.107.74.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xc09wqgvmzyoNJn91waZ0XSPtvRol27X4vr9b8/b3ROVjWtkKHZrY7F6+qhlZRCvaIakK6N/3jumhoacqL8wd6aahNlR4uIIQdhJg7YxKK612eN2o2Lrezf3tfcwszkHdDOPNIwK8CgaQOYlzFcsjQepN+UOMgFVMnjqCm2eyaLKMMegDnML2SWer20kkHTmv8GCW1hbzXlognWcMlbzFgOr3BnXySKY2ye7FpYlbZ8L7LejZ2KePvagXRjTSc+Y1DiiYZKrPeQaU9ih/kW8kYK9Pl1vShk7OQKr8gBs1xGkancvH7OmXQQbgfgYWMzvbD6KIso1UImI1gw4s3bDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+GoGY+GUgqIRtQqWdgu3czzWpnF7iySoPBUEO8M9C4=;
 b=BTLR1UMA2vqPH5HCLleQtXqMMIZlt8z+1Y75uy8EKtskSt1/KKgGmUA9FOYgolVBe/48k6EKV61NSlo0Jyo7KdK4D0tYpVGNiF0YokZwF9CpAj1xOvZM8qhkj6GYC2HBExjTx5greOF+UrD7KgjpyZXW44rAZRFqiFX/+6EIEC8SJQoPbwu+pTFKrvOfF4x0nq2BXzuk7JdMCdpSZtxABb75GRIwUZ8HXAg60X8yLScQVaS6lzWGy/sJRCAKHNC8+O68qezYZHIveeTz+hmICWO6U76iYhShEd9a1i8b0wpGh2zCTK//3QQpEd4RT5FknIQLyxRraYtd//KkMRkKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+GoGY+GUgqIRtQqWdgu3czzWpnF7iySoPBUEO8M9C4=;
 b=QyKKISS0B2h0OHbge0gHbvdmqXL1hjQZ4ZxGJ962RPBVl/1yAwUZl6ss2jrum6mMyOBDepGZwCqBMVtP8GAWFBAgUMJo3sJ3i6aj1WmF+S4yCxcoUZpTMZ/0SmyAviPWNRtwACpJjH7p7Bo9z0X/Mha0TgnIUB5kOktB3RdSrY8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9478.jpnprd01.prod.outlook.com (2603:1096:400:1a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.5; Fri, 28 Nov
 2025 10:37:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:37:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Topic: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Index: AQHcYFI5ecl+CAjg4kmC2W+P2g89ALUH5J4w
Date: Fri, 28 Nov 2025 10:37:17 +0000
Message-ID:
 <TY3PR01MB11346477DC214777A4D94045F86DCA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251128103148.161544-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251128103148.161544-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9478:EE_
x-ms-office365-filtering-correlation-id: 8f567f4e-23b3-4c7d-4d1c-08de2e6a1a52
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?o/bR9nVsPk+7nN/kT6GQ9t727J/hRnv8Z7Ckdft1SC+LdWajo0o11F8jkR?=
 =?iso-8859-1?Q?oT5ZCKte38M+vUMDDNcDL9LFL1RNQTIrdyAdjpVABOF1q5DzyUwLy85X0H?=
 =?iso-8859-1?Q?EXOlSviBDNosURg3/oeXSCCn7blp9t6SdDiMe6SSiHQLrAEZO05uycXxOE?=
 =?iso-8859-1?Q?pzKSrnz8DtBM9tJppssjWOwOdl2zCLyOeQIohczgWQzvKLDqgyldDXKdBS?=
 =?iso-8859-1?Q?3cOR50sS3QJXshYThFbaU2ISn3dOveTLi8+6ANuhRYsJVddMlYq9an2Svk?=
 =?iso-8859-1?Q?2QmhxGrGxXfugjkK/4rkCy248zP1YUARkQtGR8kB5aRNQKp+2Q7RsmPTB5?=
 =?iso-8859-1?Q?DElyyD02ACZeWJ+35u/1hVGrlpe5TvOLL89nUYB4WGGxJdK4GPWttQNfFO?=
 =?iso-8859-1?Q?ak9a+C5pfqemmIc33jHkVYErWvX1OR9MYj0U7H3DDrTYoqLspduDJF7pjI?=
 =?iso-8859-1?Q?mZdBLUsEOkGQYV/OXHICVvcO7QJ98Fhlj5J5btGoRYTw1NIRRfLEY7ZGB3?=
 =?iso-8859-1?Q?f4i+e4OFBcuc16soH4yW5ugPpvVsvv61eHfwb2V2hDmpt7aSIpr0rl+0t/?=
 =?iso-8859-1?Q?LZam2NCKcxVP6Ljdx4cZ8YvfQjx0p8T6PQa0/CNFTrsyQuvA3KXDjpRmcs?=
 =?iso-8859-1?Q?hkghDFOD07uMedNPFpoY/cEpFm+RE1q7kVMXT/ckuML4VkcaVd5SaMhQEP?=
 =?iso-8859-1?Q?UXmHzMs2xB/uTLQyEAItbs9T+J8AXn+QWJWkv1JHjmXs8nUDed5Bav58H+?=
 =?iso-8859-1?Q?3hqb/QviKIWK8JcLVaJXJISo6k9SuzRezFreXwKdFXsFB3YpIxI5D2Mr/I?=
 =?iso-8859-1?Q?v2XGNCiejQrvM2IVDbikxocou7CgSEqiycsEwY36eHFGzjzhRWtsMakWw8?=
 =?iso-8859-1?Q?dwhyzF4AqBnlL0EO64rrl0zwKDBWzegZOKVaMx/sPNyy0VDhEtTMpYkl46?=
 =?iso-8859-1?Q?yebKPMxhEMR7ZnEmb4bDhTDpR3MU23oNxr7AhqUvf+a1M6pIByUnewfyky?=
 =?iso-8859-1?Q?zRVZfEy29pR3BASXgFmXQjjoa0ZLAAtk2HjpB/WZkJNhdTQ9u172n+Urzx?=
 =?iso-8859-1?Q?e+/q9SvQFI+HF7znifQzAD3vedeb0eIIYzb2mRHqh/IyMP0BPYLdvOGxne?=
 =?iso-8859-1?Q?mINnvpScMojK8q9IJ1FFTVprElv9QSAYutFGOVMgmN/hjPakJXM7hT5qEx?=
 =?iso-8859-1?Q?tQhT4SkdKQBTyGFpHq3wJTlAyAWPaAxSFn+PV6AuPXwjWBQf0ChNnHLkPd?=
 =?iso-8859-1?Q?w4k55lCrXizQH2kdDK6Oa+L9p0UdknU0GFZzwaz3RjF6S3uAkgVR6dXHCc?=
 =?iso-8859-1?Q?5bSO31W29yGVo4b12j8+fb62KGdoCUxL+ciV1nclXNn38epqGiR7tFLPz6?=
 =?iso-8859-1?Q?MW7X0ccnEaFqWSewvKIOjAuOSGSEQh3XFOcjEaZzAIJlpMWzhJmap0Ezkj?=
 =?iso-8859-1?Q?qwoHB3tR0iW4arR7UiuIFmjVkzlwdMBptXSb9A59GPhhtN0fnwwGUiaOv5?=
 =?iso-8859-1?Q?9drbVQCZIqFSV0aOhoOgwDL86mMPCRpWGMBymp7XdLqe8ONf+EHKLX8Lmo?=
 =?iso-8859-1?Q?erYXN6MKlxOMULD9xVDRAZcxdsdR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?no8uFa5Q4XsOALgxH9ILJVC6mvJfgBQZWdCPPRhlHNtprBUSDqj5JS7qJQ?=
 =?iso-8859-1?Q?X4QSiwq5MxzJXoGraUEqJx9gHRPNV/L5RkYCfBfKLseuC51/nP7r4hw5ID?=
 =?iso-8859-1?Q?UJnWXKj2VuLtEb4WLz3yMmqOf1qUW03AALrT5ebPSSqfPnRgJbmc4zzrFq?=
 =?iso-8859-1?Q?HHkwyDK4kY1GnitDIHRCSwRyWF6uzYTvLHf6PPZ6C1LTzxez1kvNT/R7Ht?=
 =?iso-8859-1?Q?pgMunXB7vldwE/9e4l2/a7DXjyY3imjn2EEFgMGQ+tcWx7a3Wkf/CuKODk?=
 =?iso-8859-1?Q?2GJJqe2XbHf0cPZRKe29XQkr3LAgbrLKl2jzjoOU1wXhILJfhs3/JrDApl?=
 =?iso-8859-1?Q?kh8nDfVWlqj6x1y8yBEolKc/qi1cqXvYD1P3/aoqqcWPWZw9s23hY2cpUu?=
 =?iso-8859-1?Q?0tdafx1cQXgYkoWBeQ2R6DL2rI/1A9MvPCEOfn6C7QroTGew7s61VzNYBY?=
 =?iso-8859-1?Q?jLpsASzdRFKYo38PZUSBA1wW1msS/36v5QujILGnzwzdjUaisye42P3Ax5?=
 =?iso-8859-1?Q?j+g3FOnAPPsMQZEhx6k7vC505yUApsdaZf9LJ5659xvxluiicB4sdQQOSV?=
 =?iso-8859-1?Q?IvvBYEy7JMRTJH95YfMl0QtrvAMbFNTOgqK8qvuBIFysZ8JCtNQzTNLgH1?=
 =?iso-8859-1?Q?2N4bJSSEgJxekKDBrBQUvabgFj5OCWSR52T1VWWZFlDJJAIMnAZh9Le/mQ?=
 =?iso-8859-1?Q?wO067Eyv5qEZthfXHH5xG+GbnTc3UySxdHhEHJg3VmE35uQQOsaVS/GEGD?=
 =?iso-8859-1?Q?oZ2X/NBk4GUZN16QEzyg6Sw28Za8teiTPTxElvWvtkfE2CaHv2VJqj0Rwa?=
 =?iso-8859-1?Q?bmTuYs5LEgHdB5ELkVrJiye5BjrOiEHGtF9UnLeMlC//ig2rcUUkkuWt2m?=
 =?iso-8859-1?Q?NpuTija8EP2dTIC7tbAt61t13YycOTu+y/rGWsuAj9pmEAzXql7Mp74H8R?=
 =?iso-8859-1?Q?JoN+HvYhq/5r5z3sfu5F72Mi7+izQStjITvowNgh1rLdiRylOb9PspVaAO?=
 =?iso-8859-1?Q?Sy/DABmA777QKnCDuZPdXLXalqmQ3/kyh4+btL+t8QORUkp/tB21gkbIB3?=
 =?iso-8859-1?Q?HWAxHIsJELiy7FvPp+hSGMlSM1DH0l45iGXNdnjA5hp63idjR12YPrDK/c?=
 =?iso-8859-1?Q?LDFr6H7TFQgf5h/lhRmvWuQ8zCUWMMkp2SQXGy8AkLuE4W0UVDmRS3ebpu?=
 =?iso-8859-1?Q?hP+fhr7pJOR00rz73Be6ehLh54ZXBnNFt4o9ZttvUyRfL+88kmFJwG6pHi?=
 =?iso-8859-1?Q?tL2r7GcaPlAI2Msn8n+8O4ej4v4v3MRh5Kcyd7qSf8ewcBPK/fl28L2aUu?=
 =?iso-8859-1?Q?/g5vua+WAinpnXQ5mZyfU7nnSN5ddVfteDHiv+4rAlojAg1UE8Q7zU79nj?=
 =?iso-8859-1?Q?pEq4rK2vKG351UulOd8S/nK7c8V0TPBhlAqAq1ab17rP5xd3VIwu/V/tBO?=
 =?iso-8859-1?Q?RNw/60hRMiB8ROmCvsdSesxb02P3IbiO3KgTJAtzyF31XQFCGGUH/qPA6x?=
 =?iso-8859-1?Q?38DVCwXC4QxgGNqv8nq3QITw7o7wheFUM8vrLqXlwL0uMsfZHd79ciM9fF?=
 =?iso-8859-1?Q?d6KCY8VcW4bSCf/scgq5llVglyzwExW8noPrUBvh3SQJR3ziNDmQANp7Pg?=
 =?iso-8859-1?Q?PydKhxY45REOi+dH6TNcZoT1QVT3FoFozqFwNXk/gNi7q3FTQPI5adjQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f567f4e-23b3-4c7d-4d1c-08de2e6a1a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 10:37:17.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZM32+ePEPUoJUOHvDxkrWP78/YpTg/CkAZ3uCbi1wUIaZb7iL1xAE8OHOqs8zslk7JBjTM6UDLm9u5UWWz3JOQhKe4WU3MerP03fGFJ7d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9478

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 28 November 2025 10:32
> Subject: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform callba=
cks
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Convert the rzg2l-gpt driver to use the new callbacks for hardware progra=
mming.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Rebased the patch.
>  * rzg2l_gpt_is_ch_enabled() fit into 80-character limit for consistency
>    with other functions.
> v2->v3:
>  * Prepared as a series.
>  * Created separate patch for fix for reinitialization of the cache
>    variable in disable().
>  * .round_waveform_tohw() do not fail if the requested period is too smal=
l
>    but use the smallest possible value.
>  * Added lock in rzg2l_gpt_read_waveform().
>  * wfhw is reinitialized in rzg2l_gpt_read_waveform if channel is disable=
d
>  * Optimizated rzg2l_gpt_is_ch_enabled() to avoid redundant reads to
>    RZG2L_GTCR(ch).
>  * .write_waveform() returns error incase of invalid period for second
>    channel.
> v1->v2:
>  * Dropped modifing hardware from .round_waveform_tohw() callback.
> v1:
>  * https://lore.kernel.org/all/20250805065032.193766-1-biju.das.jz@bp.ren=
esas.com/
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 192 ++++++++++++++++++++++--------------
>  1 file changed, 118 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c in=
dex
> 4856af080e8e..2f424a7b05cc 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -86,6 +86,13 @@ struct rzg2l_gpt_chip {
>  	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
>  };
>=20
> +/* This represents a hardware configuration for one channel */ struct
> +rzg2l_gpt_waveform {
> +	u32 gtpr;
> +	u32 gtccr;
> +	u8 prescale;
> +};
> +
>  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)  {
>  	return pwmchip_get_drvdata(chip);
> @@ -153,7 +160,8 @@ static void rzg2l_gpt_free(struct pwm_chip *chip, str=
uct pwm_device *pwm)
>  	rzg2l_gpt->channel_request_count[ch]--;
>  }
>=20
> -static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8=
 hwpwm)
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8=
 hwpwm,
> +				    u32 *gtcr)
>  {
>  	u8 ch =3D RZG2L_GET_CH(hwpwm);
>  	u32 val;
> @@ -162,6 +170,9 @@ static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_=
chip *rzg2l_gpt, u8 hwpwm)
>  	if (!(val & RZG2L_GTCR_CST))
>  		return false;
>=20
> +	if (gtcr)
> +		*gtcr =3D val;
> +
>  	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTIOR(ch));
>=20
>  	return val & RZG2L_GTIOR_OxE(rzg2l_gpt_subchannel(hwpwm));
> @@ -220,54 +231,38 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struc=
t rzg2l_gpt_chip *rzg2l_gpt,
>  	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);  }
>=20
> -static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> -			       struct pwm_state *state)
> -{
> -	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -
> -	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> -	if (state->enabled) {
> -		u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> -		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> -		u8 prescale;
> -		u32 val;
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> -		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> -		state->period =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, p=
rescale);
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> -		state->duty_cycle =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, va=
l, prescale);
> -		if (state->duty_cycle > state->period)
> -			state->duty_cycle =3D state->period;
> -	}
> -
> -	state->polarity =3D PWM_POLARITY_NORMAL;
> -
> -	return 0;
> -}
> -
>  static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)  {
>  	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * pr=
escale)),
>  		     U32_MAX);
>  }
>=20
> -/* Caller holds the lock while calling rzg2l_gpt_config() */ -static int=
 rzg2l_gpt_config(struct
> pwm_chip *chip, struct pwm_device *pwm,
> -			    const struct pwm_state *state)
> +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +	bool is_small_second_period =3D false;
>  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
>  	u64 period_ticks, duty_ticks;
>  	unsigned long pv, dc;
> -	u8 prescale;
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
> +	if (wf->period_length_ns =3D=3D 0) {
> +		*wfhw =3D (struct rzg2l_gpt_waveform){
> +			.gtpr =3D 0,
> +			.gtccr =3D 0,
> +			.prescale =3D 0,
> +		};
> +
> +		return 0;
> +	}
>=20
>  	/* Limit period/duty cycle to max value supported by the HW */
> -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz=
, USEC_PER_SEC);
> +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns,
> +rzg2l_gpt->rate_khz, USEC_PER_SEC);
>  	if (period_ticks > RZG2L_MAX_TICKS)
>  		period_ticks =3D RZG2L_MAX_TICKS;
>  	/*
> @@ -278,21 +273,25 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
>  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
>=20
> -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
>  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> -				return -EBUSY;
> +				is_small_second_period =3D true;
>=20
>  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
>  		}
>  	}
>=20
> -	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks=
);
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> +	wfhw->gtpr =3D pv;
> +	if (is_small_second_period)
> +		return 1;
>=20
> -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns,
> +rzg2l_gpt->rate_khz, USEC_PER_SEC);
>  	if (duty_ticks > period_ticks)
>  		duty_ticks =3D period_ticks;
> -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> +	wfhw->gtccr =3D dc;
>=20
>  	/*
>  	 * GPT counter is shared by multiple channels, we cache the period tick=
s @@ -301,6 +300,61 @@
> static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm=
,
>  	 */
>  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
>=20
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_round_waveform_fromhw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const void *_wfhw,
> +					   struct pwm_waveform *wf)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	const struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +
> +	wf->period_length_ns =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, =
wfhw->gtpr,
> +								  wfhw->prescale);
> +	wf->duty_length_ns =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, wf=
hw->gtccr,
> +								wfhw->prescale);
> +	wf->duty_offset_ns =3D 0;
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   void *_wfhw)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +	u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 gtcr;
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
> +	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
> +		wfhw->prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
> +		wfhw->gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> +		wfhw->gtccr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> +		if (wfhw->gtccr > wfhw->gtpr)
> +			wfhw->gtccr =3D wfhw->gtpr;
> +	} else {
> +		*wfhw =3D (struct rzg2l_gpt_waveform) { };
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    const void *_wfhw)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	const struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 gptr;
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
>  	/*
>  	 * Counter must be stopped before modifying mode, prescaler, timer
>  	 * counter and buffer enable registers. These registers are shared @@ -=
319,14 +373,20 @@ static
> int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
>=20
>  		/* Select count clock */
>  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
> -				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
>=20
>  		/* Set period */
> -		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
> +	} else {
> +		if (wfhw->gtpr) {
> +			gptr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> +			if  (wfhw->gtpr <  gptr)
> +				return -EBUSY;
> +		}
>  	}
>=20
>  	/* Set duty cycle */
> -	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
> +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), wfhw->gtccr);
>=20
>  	if (rzg2l_gpt->channel_enable_count[ch] <=3D 1) {
>  		/* Set initial value for counter */
> @@ -335,44 +395,28 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		/* Set no buffer operation */
>  		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
>=20
> -		/* Restart the counter after updating the registers */
> -		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> -				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> -	}
> -
> -	return 0;
> -}
> -
> -static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
> -			   const struct pwm_state *state)
> -{
> -	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -	bool enabled =3D pwm->state.enabled;
> -	int ret;
> -
> -	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> -		return -EINVAL;
> -
> -	guard(mutex)(&rzg2l_gpt->lock);
> -	if (!state->enabled) {
> -		if (enabled)
> -			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> -
> -		return 0;
> +		if (wfhw->gtpr)
> +			/* Restart the counter after updating the registers */
> +			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> +					 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
>  	}
>=20
> -	ret =3D rzg2l_gpt_config(chip, pwm, state);
> -	if (!ret && !enabled)
> +	if (wfhw->gtpr && !rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm,
> +NULL))
>  		rzg2l_gpt_enable(rzg2l_gpt, pwm);
> +	else if (!wfhw->gtpr && rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, =
NULL))
> +		rzg2l_gpt_disable(rzg2l_gpt, pwm);
>=20
> -	return ret;
> +	return 0;
>  }
>=20
>  static const struct pwm_ops rzg2l_gpt_ops =3D {
>  	.request =3D rzg2l_gpt_request,
>  	.free =3D rzg2l_gpt_free,
> -	.get_state =3D rzg2l_gpt_get_state,
> -	.apply =3D rzg2l_gpt_apply,
> +	.sizeof_wfhw =3D sizeof(struct rzg2l_gpt_waveform),
> +	.round_waveform_tohw =3D rzg2l_gpt_round_waveform_tohw,
> +	.round_waveform_fromhw =3D rzg2l_gpt_round_waveform_fromhw,
> +	.read_waveform =3D rzg2l_gpt_read_waveform,
> +	.write_waveform =3D rzg2l_gpt_write_waveform,
>  };
>=20
>  static int rzg2l_gpt_probe(struct platform_device *pdev)
>=20
> base-commit: 7d31f578f3230f3b7b33b0930b08f9afd8429817
> prerequisite-patch-id: 994e29857383f8aa61bdc53df997f6e28f5cb723
> prerequisite-patch-id: c122f15fbeb0c18317e59981bcad9831f472bb57
> prerequisite-patch-id: 069b26e8ef7fc1d961488b3c9fee3cf0bf82d44f
> prerequisite-patch-id: 63bfa4ff3912cdb0f3a897b1f0286fe7eb3ca08d
> prerequisite-patch-id: 81a4395c1935f9cc757743c5de646bf17a1bcfa0
> prerequisite-patch-id: 34306f03faabbe6a0c238225e748b1d76726fd2c
> prerequisite-patch-id: 500209adf95b4f460e2a6264e2b9c5f3a3ad4640
> prerequisite-patch-id: 51945f93d2fd9c9433b62d847430d4bd21d0eafe

Oops, my script does not removed the unwanted patches.
I have resend[1] manually removing prerequisite-patch-id's.

[1] https://lore.kernel.org/all/20251128103431.161591-1-biju.das.jz@bp.rene=
sas.com/

Cheers,
Biju

