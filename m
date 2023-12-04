Return-Path: <linux-pwm+bounces-279-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D28037A9
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC361C20AF7
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422FA28DB9;
	Mon,  4 Dec 2023 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="e6HyxjCX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D33B9;
	Mon,  4 Dec 2023 06:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz/Vg6FXrZkOJjlfAmGKSiJ0sCn/Uah7uwDHaFK7BCQOOX66XtueVfikZB/usUeUdkd/lsgFmJ4CHLlPkuM0RPa5d6UwdHNfX6hBsp5g08ugZPGW2/bCgwVH7KCP5Wx6JUJU0WBJcp8g0EaDVW3JE8Cctev5NbEckRjFM2dlX0G6RwLFz3JEZLvCpfEeK3KujUbn5qStjpl6QKaFQ1Nfa8qKfLS+vEbpwDbFKSUcQs03qMuCVBj8wqdr0bFuM48RxfLMHsVeVBNoXBtW69xto4XNdbx28yMk75kulwePYywx1EFwdvsRHJmq8o6sUUBDFMvi/1p0y87TsxPIPIM1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kfx+unM2nw6BA//apt/eU2fj8MH4x88tNz/2rdbFOQ8=;
 b=D46qwccYomOsE9sqkBrMi9wahy4eL+HuoH+vbaX6dl6+JQplt/GdDBZcMiRYBf0sYhxkoNpTpS4WvrArVETyzFsxpCqcF8a8NooNlHeXGybFHZk4+o4yipFthJD7WMWPmSUENUV82SU0DkngAUqh/3KrorCCDOSGmhAjdAWoPqgx80OtSR++ZBJa3sXCpefKowDM1LmCYng7gW9fZnwePNhYU3pjwRiOUdwHdGYMitA7u09q1fFadfZD5e6kIKl95kTREjTDajC7ZPvM84IQwCAidfIOjKGqael7R4+kFDYbGpBHBYygmP4aQDEdMmIGfmW4gQeMecaTZV6NC0VW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfx+unM2nw6BA//apt/eU2fj8MH4x88tNz/2rdbFOQ8=;
 b=e6HyxjCXMZ2/TAY75NQcGRZgZlmJLgbikvmFFMSTfGpY2CJUOAwF9r70BcyLDqb7po2OXzZVsaZdLU+YuNMC/XbL0jg+Mk3WZgLl1QgXfOVPdpRG8PIZwKwtiZdM6mtaCRGPC/sTObdp8IMHkFk64t2ChJC8mrp2caViHKCGc7A=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB8800.jpnprd01.prod.outlook.com
 (2603:1096:604:158::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:55:02 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 14:55:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCZS+Lw
Date: Mon, 4 Dec 2023 14:55:01 +0000
Message-ID:
 <TYCPR01MB112694451EEE535AD01A6CAC08686A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB8800:EE_
x-ms-office365-filtering-correlation-id: 51cc1b16-7ec6-4442-c9b5-08dbf4d8fe2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uZzQj/tR6aqUuxQMVXuXHV4A93S0IF9VV5jrvkQtO8Nhv6EcUBceufG5TIqsEmCeLsXedh/PPJQNL2yvQ63epYcC6WGKVVyc8y/dAUURLkLfHIvX4UvwuBgMnNECWOMaPuCmcd2RR9uQz2MmiCs5sB1J7UW6rV/1ilcGKgQ0m3PZpKuQWGFPqABHTgpd4TcolfhpFMvdpdm66ftwFSqiSLGgfuHRHXdKUo1E4kjoXy4QMUCndBZu12vm6sQmq0EISRflWQPFNhFupySx7BQ6ALZCO4HSkcUfeOyEaOfsteOupvp4dPKwmbcWa+OijI03XfneX1gR07ROTEvN3RMKAWFVD9SZTcPeXjjH06b73dXyC0gcS2Yk5lKyea4bylig2vzHtA0eCeqlPiaXk06hlOz6AM2QMqNOmw2/S1ZD97tfEbsiunuMp9bfVc8GacHSpicWlWo812YlxEy27nJZeFqqc/FZHZZuQuyZbJfBT/vk0u/Yn7Em3YgiZxKm3N5pcYjVAy5BW+5yYY1m1x08bkGxcOJeDoVNeNGdTU69zod6kvJUwnhlAbmY+OKFoXjwtog7OsQxSpz+q5d/jm0DKYfANoJIz5MPk8zwzGMAEWsW2USZGh53aT5kLveSfNvQFKGZ1ROxglpu4uVjnZCuSw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(33656002)(38100700002)(55016003)(122000001)(38070700009)(52536014)(2906002)(83380400001)(5660300002)(26005)(30864003)(107886003)(53546011)(7696005)(6506007)(9686003)(478600001)(71200400001)(86362001)(4326008)(64756008)(54906003)(66946007)(66556008)(8936002)(66476007)(66446008)(76116006)(110136005)(316002)(8676002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mJx9oeGwtf2Ww+WGPme46rrq8dhVHYIPnyo30scI8dePyd2uQE3Sovn1sw?=
 =?iso-8859-1?Q?OpVbXt1u117d7txLAMw6TigD6JqqDsygJ7fqUkWu49YZOqnCIOsvzXuWf9?=
 =?iso-8859-1?Q?NyG5wrUzISd8nUhFyjhy9WJb+efhHLb8JMmVftZCOlhL2pbgN1wIs0sRP4?=
 =?iso-8859-1?Q?OpVPzurpZdpgjaDU36YoXVFSDWjcGTv6MjueRFDW5/XIZSc7jhvZvjnY7c?=
 =?iso-8859-1?Q?6TuTgUu37GuLOkdnN+O7LYwsmeUEbTfrdX+1BIil1Ev+f6yWocjBAIdFtg?=
 =?iso-8859-1?Q?FAzOxsy3rrAKVgXCFCTKKaXLMOmr9d254x7DgTgyIrTu8sxbTm1/BxHnAl?=
 =?iso-8859-1?Q?VE+gssg3Z1Tb9+JyTDpv5UjBzst2k88RYkywHxR5qv1HXFCTE1V3t0P1Pm?=
 =?iso-8859-1?Q?64H5RGe3kQWH0+gf7MlomL7cD2/MVcLyDptmgslAoFBPBoI/GIVfrdekZC?=
 =?iso-8859-1?Q?bTaB4HC7ddhy9A9nSRQJxwgwn/594o1puLl1dNOPlXH9v+1rQI1veFswjF?=
 =?iso-8859-1?Q?JK0J084e4l7ZFY1HABx2CdfxfYWwb+eEfaE3LT+rhR9kukl+gtyyExLk7L?=
 =?iso-8859-1?Q?r987TXsV4Vn32rwIDKKC3FYgqJ/xIhnFypF1fu5VlAa+YmjplgVZZZs8OJ?=
 =?iso-8859-1?Q?Z8lQVbr3YJT6CkwFrdzVhfg17ZbDfTRFJP0v6R6XcrRe7EIhF48rlebwjy?=
 =?iso-8859-1?Q?Gk1Nof6+buxMdzztf4KLwS7UUyml7Q1scPTD3eRj3ccqoR/3B28tsHUp+A?=
 =?iso-8859-1?Q?ijJrs5XPrOf104/BMfJmia2Arn+L4d/ihb2IDW0pDG//a6tfm5A0TN2gZu?=
 =?iso-8859-1?Q?ArDREYBXUJ3SLk8j6BvjDtC8woBDmGVLKp/GCefMTBNaGO/rVeLbN1dKvT?=
 =?iso-8859-1?Q?gl/K/RvjEWvIOysRGPNvQ9ul3hg1bCAco6qtvldGZ3c9IrDVhlAFFtqdYf?=
 =?iso-8859-1?Q?COd/WFVZZApYwbylBHtwyWW0jxLJkKFCRzZ4/9isRXjF5S5SsbNr0z7eqX?=
 =?iso-8859-1?Q?Q61ka6My9ap9TLyRvkuBRWbQqJmP8hy+RjQoOcqkO/byLl/GhTMOeJlbeu?=
 =?iso-8859-1?Q?Kxr0zcnjcgJnWOt313DPnCOoC8LLBrb18z6zJJOdmaiONom5z7jExkOi1t?=
 =?iso-8859-1?Q?M3roDLhVKbc2ZZk0ZME/pq9nf24itj6xVRDZdxliqr3U3DQIk/s0q1t5lf?=
 =?iso-8859-1?Q?0QxWzojy+NU5W9m6KJkyUZdXQ6YnJZA+ZTmasmUEw5gUtbXPzx9ytUJL3P?=
 =?iso-8859-1?Q?UTEybtyoAOTwXvWVSdjdesGj7RbIV3PIht2BNgUi1eEFdCm07JWmEdDRun?=
 =?iso-8859-1?Q?IsNpptvNdBeRIvIcD/4ln8mdS7fK0Zti1oiii2fDmTPjOH8ngq3VZZlxpH?=
 =?iso-8859-1?Q?jqeq0h/ztphc8HEl0PTWafKkBwgASj3UwoeoBP+A1NDJyN+M4FBE1uQGSQ?=
 =?iso-8859-1?Q?ObBfrfgonjU8Aus7xrRJszuLI4P2CDq+ebxQeQqyvNx8Bs2nbCM1yCDrPS?=
 =?iso-8859-1?Q?cof6U9PB1liFf4x2ofzM1N7chy4erV41xtxnAMlUkqucvHAEImWp162Zmo?=
 =?iso-8859-1?Q?0R6PRowoUelOeenP43G9SJzKth6W/rLB7i/qN49g/k/Sb2kjJuTHGr+GV/?=
 =?iso-8859-1?Q?mHyhgU1Q6snhVZ4lb6BCHJm49lXJ5YoBTbuT6oYr4hgGLFWa1hj1GEuA?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cc1b16-7ec6-4442-c9b5-08dbf4d8fe2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 14:55:01.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZZ+x2Y+0gpIQT6dIJ7Bvb1deNs32tV58Be2TexBq9zU3AqeGg737Y2ZmfOAprCiYLrfgC69sDnJobJ8UjlZfPGPaDxP4eARFl9Mk6CsNdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8800

Hi Uwe,

Gentle ping. Are you happy with this patch?

Please let me know.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, November 20, 2023 11:33 AM
> Subject: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits =D7 8 channels
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
> Add basic pwm support for RZ/G2L GPT driver by creating separate logical
> channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v16->v17:
> * Added ret =3D dev_err_probe() to avoid return success in probe().
> * Dropped unneeded MODULE_ALIAS().
> * Dropped .owner from struct rzg2l_gpt_ops.
> * Fixed build issue reported by kernel test robot <lkp@intel.com> by
>   replacing DIV_ROUND_UP()->DIV64_U64_ROUND_UP() in
>   rzg2l_gpt_calculate_pv_or_dc().
> * Added max_val to struct rzg2l_gpt_chip to compute maximum period
>   supported by the HW in probe() and limit its value in apply() to
>   avoid 64-bit overflow with computation.
> * Added helper function calculate_period_or_duty() to avoid losing
>   precision for smaller period/duty cycle values
>   ((2^32 * 10^9 << 2) < 2^64), by not processing the rounded values.
> * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div() as the former is
>   giving warnings with CONFIG_PWM_DEBUG enabled for very high values.
>   eg:
> 	echo "###### Medium setting 11000 sec =3D 3hours ##"
> 	echo 11000000000000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
> 	echo  5500000000000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
> 	dumpgptreg
>=20
> 	echo "###### High setting##"
> 	echo 43980465100800 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
> 	echo 23980465100800 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
> 	dumpgptreg
>=20
> 	with mul_u64_u32_div():
> 	###### Medium setting 11000 sec =3D 3hours ##
> 	Read at address  0x10048464 (0xffffb9426464): 0x400746FE
> 	Read at address  0x1004844C (0xffff8fdfb44c): 0x2003A37F
> 	Read at address  0x1004842C (0xffff9855b42c): 0x05000001
> 	###### High setting##
> 	Read at address  0x10048464 (0xffff9101b464): 0xFFFFFFFF
> 	Read at address  0x1004844C (0xffffaee0544c): 0x8B95AD77
> 	Read at address  0x1004842C (0xffffbbc8a42c): 0x05000001
>=20
> 	with mul_u64_u64_div_u64():
> 	###### Medium setting 11000 sec =3D 3hours ##
> 	Read at address  0x10048464 (0xffffb3185464): 0x400746FE
> 	Read at address  0x1004844C (0xffff81ebb44c): 0x2003A37F
> 	Read at address  0x1004842C (0xffff904fd42c): 0x05000001
> 	######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=3D1 pol=
=3D0
> 5500000000000/43980239923200)
> 	 High setting##
> 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent
> (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0
> 23980465100800/43980239923200)
> 	Read at address  0x10048464 (0xffffb5bb3464): 0xFFFFAA19
> 	Read at address  0x1004844C (0xffff99b8c44c): 0x8B95AD77
> 	Read at address  0x1004842C (0xffffbba2342c): 0x05000001
> v15->v16:
> * Replaced the macro DIV_ROUND_UP_ULL->DIV64_U64_ROUND_UP
> * Added DIV_ROUND_UP in rzg2l_gpt_calculate_pv_or_dc() to avoid loss of
>   precision.
> * Replaced min->min_t() in rzg2l_gpt_calculate_pv_or_dc().
> * Added a comment for rzg2l_gpt_config()
> * Replaced mul_u64_u32_div()->mul_u64_u64_div_u64() in rzg2l_gpt_config()
> * Fixed the logical condition related to counter stop in
>   rzg2l_gpt_config().
> * Dropped pm_runtime_resume_*() from rzg2l_gpt_config() as it is managed
>   by rzg2l_gpt_apply().
> * Moved pm_runtime_resume_*() from rzg2l_gpt_{en,dis}able() to
>   rzg2l_gpt_apply().
> v14->v15:
> * Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chip
>   based on feedback for pwm_mtu3 driver.
> * Updated copyright header and commit description by replacing "This patc=
h
>   adds"-> "Add"
> * Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced ch_index-
> >ch
>   throughout
> * rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
>   enable_count.
> * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and propogated
>   the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
> * Reduced variable scope in rzg2l_gpt_get_state() by moving most of
> variables
>   inside the if statement.
> * Updated rzg2l_gpt_get_state() by moving duty > period check
>   inside the top if block.
> * Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify config=
.
>   Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
>   min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
> * Updated rzg2l_gpt_get_state() by moving duty > period check
>   inside the top if block.
> * Simplified rzg2l_gpt_config() for updating registers
> * Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
>   to make balanced PM usage count in rzg2l_gpt_reset_assert_pm_disable()
>   For case were unbind is called before apply where pwm is enabled by
>   bootloader.
> * Added error check for clk_rate_exclusive_get() and clk_get_rate() in
>   probe().
> * Dropped prescale from struct rzg2l_gpt_chip.
> * Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in struct
>   rzg2l_gpt_driver
> v13->v14:
>  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and RZG2L_CHANNELS_PER_I=
O
>  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added
> comment
>    for cache for prescale variable.
>  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
>  * Reordered rzg2l_gpt_config() just above apply()
>  * Replaced pwm_is_enabled()->pwm->state.enabled in config
>  * Replaced pm_runtime_resume_and_get with unconditional
> pm_runtime_get_sync()
>    in config().
>  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
>  * Added error check for clk_prepare_enable() in probe() and propagating
> error
>    to the caller for pm_runtime_resume()
>  * clk_get_rate() is called after enabling the clock and
> clk_rate_exclusive_get()
>  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
>  * Added pm_runtime_idle() to suspend the device during probe.
>  * Moved overflow condition check from config->probe().
>  * Simplified rzg2l_gpt_reset_assert_pm_disable().
> v12->v13:
>  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
>  * Sorted #include <linux/limits.h> alphabetically
>  * Added a comment for mutex_lock to fix check patch warning
>  * Replaced data type of duty_cycle from unsigned int->u32 as
>    the maximum value stored is U32_MAX.
>  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related
> code.
>  * Improved rzg2l_gpt_get_state() by setting "val =3D rzg2l_gpt-
> >duty_cycle[pwm->hwpwm];",
>    and factor "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statement.
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
>  * Updated rzg2l_gpt_get_state to use cached value of duty
> cycle/prescale,If the PWM
>    is disabled.
>  * Simplified rzg2l_gpt_apply()
>  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> v10->v11:
>  * Used bitmap_zero for initializing bitmap varable.
>  * Fixed clock imbalance during remove for the case bootloader turning
>    on PWM and module unload is called just after the boot.
>  * Fixed over flow condition in get_state() for a prescale value of 2 &
> more.
>  * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
>    only runtime variable.
>  * Added array for Cache variables state_period and prescale
>  * Probe caches the prescale value set by the bootloader.
>  * Updated rzg2l_gpt_config() to make use of array variables.
> v9->v10:
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.
> v8->v9:
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Updated error handling in probe()
> v7->v8:
>  * Modelled as single PWM device handling multiple channels
>  * Replaced shared reset->devm_reset_control_get_exclusive()
>  * Replaced iowrite32->writel and ioread32->readl
>  * Updated prescale calculation
>  * Added PM runtime callbacks
>  * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
>  * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on both
>    IO's
>  * Moved enable/disable output pins from config->enable/disable.
>  * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
> v6->v7:
>  * Added the comment for cacheing rzg2l_gpt->state_period.
>  * Fixed boundary values for pv and dc.
>  * Added comment for modifying mode, prescaler, timer counter and buffer
> enable
>    registers.
>  * Fixed buffer overflow in get_state()
>  * Removed unnecessary assignment of state->period value in get_state().
>  * Fixed state->duty_cycle value in get_state().
>  * Added a limitation for disabling the channels.
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
>  * Added dev_err_probe in various error paths in probe.
>  * Added an error message, if devm_pwmchip_add() fails.
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
>  * Replaced devm_reset_control_get_exclusive-
> >devm_reset_control_get_shared
>    as single reset shared between 8 channels.
> v1->v2:
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested driver with PWM_DEBUG enabled
> RFC->V1:
>  * Updated macros
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read()
> ---
>  drivers/pwm/Kconfig         |  11 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 572 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 584 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 4b956d661755..bf658bb472f5 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -513,6 +513,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RZG2L || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the General PWM Timer controller found in
> Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rzg2l-gpt.
> +
>  config PWM_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> c5ec9e168ee7..50a6520363aa 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-
> poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c ne=
w
> file mode 100644 index 000000000000..428e6e577db6
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,572 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2023 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + *
> +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-use
> +rs-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - When both channels are used, disabling the channel on one stops the
> + *   other.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
> +#define RZG2L_GTCR		0x2c
> +#define RZG2L_GTUDDTYC		0x30
> +#define RZG2L_GTIOR		0x34
> +#define RZG2L_GTBER		0x40
> +#define RZG2L_GTCNT		0x48
> +#define RZG2L_GTCCRA		0x4c
> +#define RZG2L_GTCCRB		0x50
> +#define RZG2L_GTPR		0x64
> +
> +#define RZG2L_GTCR_CST		BIT(0)
> +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> +
> +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> +
> +#define RZG2L_GTUDDTYC_UP	BIT(0)
> +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> +#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> +
> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +
> +#define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> +RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
> |
> +RZG2L_GTIOR_OBE) #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE)
> |
> +RZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> +
> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS *
> RZG2L_CHANNELS_PER_IO)
> +#define RZG2L_MAX_SCALE_FACTOR	1024
> +
> +#define RZG2L_IS_IOB(a)	((a) & 0x1)
> +#define RZG2L_GET_CH(a)	((a) / 2)
> +
> +#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct mutex lock; /* lock to protect shared channel resources */
> +	unsigned long rate;
> +	u64 max_val;
> +	u32 state_period[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> +	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS); };
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip
> +*chip) {
> +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg,
> +u32 data) {
> +	writel(data, rzg2l_gpt->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg) {
> +	return readl(rzg2l_gpt->mmio + reg);
> +}
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg,
> u32 clr,
> +			     u32 set)
> +{
> +	rzg2l_gpt_write(rzg2l_gpt, reg,
> +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set); }
> +
> +static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> +				       u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch]--;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +}
> +
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt,
> +u8 hwpwm) {
> +	u8 ch =3D RZG2L_GET_CH(hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	bool is_counter_running, is_output_en;
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +	is_counter_running =3D val & RZG2L_GTCR_CST;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
> +	if (RZG2L_IS_IOB(hwpwm))
> +		is_output_en =3D val & RZG2L_GTIOR_OBE;
> +	else
> +		is_output_en =3D val & RZG2L_GTIOR_OAE;
> +
> +	return (is_counter_running && is_output_en); }
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			    struct pwm_device *pwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Enable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> +				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> +				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0,
> RZG2L_GTCR_CST);
> +
> +	rzg2l_gpt->enable_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			      struct pwm_device *pwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Disable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> RZG2L_GTIOR_OBE, 0);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> RZG2L_GTIOR_OAE, 0);
> +
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->enable_count[ch]--;
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,
> 0);
> +
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	/*
> +	 * Probe() set these bits, if pwm is enabled by bootloader. In such
> +	 * case, clearing the bits will avoid errors during unbind.
> +	 */
> +	if (test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> +		clear_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits); }
> +
> +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
> +u32 val, u8 prescale) {
> +	u64 retval;
> +	u64 tmp;
> +
> +	tmp =3D NSEC_PER_SEC * (u64)val;
> +	/*
> +	 * To avoid losing precision for smaller period/duty cycle values
> +	 * ((2^32 * 10^9 << 2) < 2^64), do not process the rounded values.
> +	 */
> +	if (prescale < 2)
> +		retval =3D DIV64_U64_ROUND_UP(tmp << (2 * prescale), rzg2l_gpt-
> >rate);
> +	else
> +		retval =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate) << (2 *
> prescale);
> +
> +	return retval;
> +}
> +
> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(chip->dev);
> +	if (rc)
> +		return rc;
> +
> +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +	if (state->enabled) {
> +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +		u8 prescale;
> +		u32 val;
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +		state->period =3D calculate_period_or_duty(rzg2l_gpt, val,
> prescale);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> +				     offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)));
> +		state->duty_cycle =3D calculate_period_or_duty(rzg2l_gpt, val,
> prescale);
> +		if (state->duty_cycle > state->period)
> +			state->duty_cycle =3D state->period;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> +prescale) {
> +	return min_t(u64, DIV64_U64_ROUND_UP(period_or_duty_cycle, 1 << (2 *
> prescale)),
> +		     (u64)U32_MAX);
> +}
> +
> +/* Caller holds the lock while calling rzg2l_gpt_config() */ static int
> +rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and
> period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->state_period[ch] && rzg2l_gpt-
> >user_count[ch] > 1)
> +		return -EBUSY;
> +
> +	/* Limit period/duty cycle to max value supported by the HW */
> +	if (state->period > rzg2l_gpt->max_val)
> +		period_cycles =3D rzg2l_gpt->max_val;
> +	else
> +		period_cycles =3D state->period;
> +
> +	period_cycles =3D mul_u64_u32_div(period_cycles, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	if (state->duty_cycle > rzg2l_gpt->max_val)
> +		duty_cycles =3D rzg2l_gpt->max_val;
> +	else
> +		duty_cycles =3D state->duty_cycle;
> +
> +	duty_cycles =3D mul_u64_u32_div(duty_cycles, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period
> value
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->state_period[ch] =3D state->period;
> +
> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only for
> the
> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,
> 0);
> +
> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> +			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC,
> RZG2L_UP_COUNTING);
> +	/* Select count clock */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_TPCS,
> +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +	/* Set period */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)),
> +			dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
> +
> +	/* Restart the counter after updating the registers */
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled) {
> +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> +			pm_runtime_put_sync(rzg2l_gpt->chip.dev);
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (!enabled) {
> +		ret =3D pm_runtime_resume_and_get(rzg2l_gpt->chip.dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.get_state =3D rzg2l_gpt_get_state,
> +	.apply =3D rzg2l_gpt_apply,
> +};
> +
> +static int rzg2l_gpt_pm_runtime_suspend(struct device *dev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_pm_runtime_resume(struct device *dev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(rzg2l_gpt->clk);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rzg2l_gpt_pm_ops,
> +				 rzg2l_gpt_pm_runtime_suspend,
> +				 rzg2l_gpt_pm_runtime_resume, NULL);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> +	u32 i;
> +
> +	clk_rate_exclusive_put(rzg2l_gpt->clk);
> +	/*
> +	 * The below check is for making balanced PM usage count
> +	 * eg: boot loader is turning on PWM and probe increments the PM
> usage
> +	 * count. Before apply, if there is unbind/remove callback we need
> to
> +	 * decrement the PM usage count.
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (test_bit(i, rzg2l_gpt->ch_en_bits))
> +			pm_runtime_put(rzg2l_gpt->chip.dev);
> +	}
> +
> +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> +	pm_runtime_set_suspended(rzg2l_gpt->chip.dev);
> +	reset_control_assert(rzg2l_gpt->rstc);
> +}
> +
> +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	int ret;
> +	u32 i;
> +
> +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> GFP_KERNEL);
> +	if (!rzg2l_gpt)
> +		return -ENOMEM;
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(&pdev->dev,
> NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> +	if (ret)
> +		goto err_reset;
> +
> +	ret =3D clk_rate_exclusive_get(rzg2l_gpt->clk);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +	if (!rzg2l_gpt->rate) {
> +		ret =3D dev_err_probe(&pdev->dev, -EINVAL, "gpt clk rate is 0");
> +		goto err_clk_rate_put;
> +	}
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;
> +		goto err_clk_rate_put;
> +	}
> +
> +	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64(U32_MAX, NSEC_PER_SEC,
> +						 rzg2l_gpt->rate) *
> RZG2L_MAX_SCALE_FACTOR;
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled
> the
> +	 *  PWM and is running during probe().
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> +			set_bit(i, rzg2l_gpt->ch_en_bits);
> +			pm_runtime_get_sync(&pdev->dev);
> +		}
> +	}
> +
> +	mutex_init(&rzg2l_gpt->lock);
> +	platform_set_drvdata(pdev, rzg2l_gpt);
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D RZG2L_MAX_PWM_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
> +
> +	pm_runtime_idle(&pdev->dev);
> +
> +	return 0;
> +
> +err_clk_rate_put:
> +	clk_rate_exclusive_put(rzg2l_gpt->clk);
> +err_clk_disable:
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +err_reset:
> +	reset_control_assert(rzg2l_gpt->rstc);
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.pm =3D pm_ptr(&rzg2l_gpt_pm_ops),
> +		.of_match_table =3D rzg2l_gpt_of_table,
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1


