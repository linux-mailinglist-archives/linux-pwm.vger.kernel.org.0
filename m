Return-Path: <linux-pwm+bounces-7768-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E1CAA3A9
	for <lists+linux-pwm@lfdr.de>; Sat, 06 Dec 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE288308CB75
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Dec 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50942DC76D;
	Sat,  6 Dec 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u8x/16Jc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F02745C;
	Sat,  6 Dec 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765015613; cv=fail; b=eHNikRw2ZrhkexCx4w+9fRYjclYMuqcbmD4quMQvA1bXsiFLHHV0xz8xdnwmJ8CNFiQhe/I4n+W9bpeUkssQNCdHUq0ngHmJS03QgCBWfG6kZE6Q+ZvCzH86EuCTh1jI+ku2hq50KJR5wPjFpjsOVwkBMSD0zIZYZ53y/30a9DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765015613; c=relaxed/simple;
	bh=x4Le6UbdeEJ22xV3/7S5U2YYgGNm3+PTDGPMrhsXv28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+EMfLrszpp7CYsrmu6ZyBjFdOR4ws8cbjmU0pOxI9pEbniga8RjPKAzoWRj6Cdn12pvAsPg75Wo0GH54jC/lpMkrdb9dNT/8Uu1l4ixOEU8fOfFjxn6WPk7prNXmRETkFCRqusYVY92Pew2yaRvD/N/cx3cWl2l6lciOZTo7fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=u8x/16Jc; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJOPUdjCG1k1/cPoG13kgkEITiUzlLyAn2Z1ttpYYHiTPpAS4x9vpZA7OLselSRwv2+cOFqitFHplN2Xoea6X0UBy4PARbPaEc7ImaiNFm4qsYSwMfFCQakRFUqZbVIrrvdS6ziGUs/nIPReQAX2TXbZm0lk8WAmuv+zA4S76OH4hj41mAgv64GfpY9istSeRZqBu5lNTqGD91BTasuIN4Vy58p00Njg4LeQaO/FFMjGeeLSeyURA5F/XWot5Q5ZoylwWp7l43Jro5krFKvU+2OslO+AtoBNX2PEHM+wVceOvxAGq2sHiYd8UuAyRqSV42KeKTMI5lEziM80PqeMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMkqA2N8pdd02MlW8RL9ZUPrhM5FtaHyqwqQLgwSudE=;
 b=FX1MAXzo+NWCTwzkR7gAw9t72lXE3kiLsendTEvn/NbfX8GtwDY6Ks+x+r1o9wovo9V9vIpLD475w5cf9HMBIJYTm66FtwW6cct2kL/jDUEBoq2zalFbf8HRj1DknPS452RW3wP19s71GbVZvf+VUT3yYEn7nXACNDXWVYh1up0724cy/ZKsqieEqvPGO1VPRM9enW6zJ2j4wB2JE+KrajpDpba/2Dk1CEXgFkrpHCgt3/WfbznVAMkNs4tKW0tJtMt33iIupGPTzMPVgoV1hWtFaWQVz6I5ElZH4t10tvGZvNW6OCt2BYzLUT6Kat9stVW3YH7Pr70C/ONvsGXokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMkqA2N8pdd02MlW8RL9ZUPrhM5FtaHyqwqQLgwSudE=;
 b=u8x/16JcF5AByZdbcOBlkPl9fRd4XL1ghiFzDv5nd2vRugTI8i47z1RgPQCK2MSm/eqUFW0wqEYIOFygpcO8QjBwaENtzM00ipE/8v8DY6Xycs6qTJCcwAwQd1aVEdpDm8WozKIvWTZ/fGcUCRD2lZ9BYN9FheZG1NeBsXi4Fsk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB16443.jpnprd01.prod.outlook.com (2603:1096:405:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.4; Sat, 6 Dec
 2025 10:06:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9412.003; Sat, 6 Dec 2025
 10:06:42 +0000
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
Thread-Index:
 AQHcLJi5Wq0nvzczj0CSEUAgjJVVOrULUGQAgAG46lCAADdsgIAABTVAgAAHJmCAAAglAIAHfdBQ
Date: Sat, 6 Dec 2025 10:06:42 +0000
Message-ID:
 <TY3PR01MB11346D4CD14B8953747C859BE86A4A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113464F283A3ED4A8AAC813D886DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ydqyvme43ul6ui7bl37kv3kuhn7js7tvkje2u4a3vasiw4kgdv@w2govkhaa3xz>
In-Reply-To: <ydqyvme43ul6ui7bl37kv3kuhn7js7tvkje2u4a3vasiw4kgdv@w2govkhaa3xz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB16443:EE_
x-ms-office365-filtering-correlation-id: 59ac1fd0-e983-41ab-d8a1-08de34af27ad
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?biDnmQxHU5ufbqxCDEZvme/NGeu/HIJ2sLJ+9jvo9CbiIvdmF0TbHAWQPd?=
 =?iso-8859-1?Q?fqpnsyj4ZEA6Yl3pmcWDcIeo523JruYrOrAhezVdZALJktMU3bZICMG50b?=
 =?iso-8859-1?Q?qbuxSPbd/BM+UXMoIoIWpPYA3cKEYLEmpYDyJiGl+dELknS/574sMrdPXD?=
 =?iso-8859-1?Q?elr6W5TlL3GDcuyzuNKuxDhbY6w97tlm+TlBRQ9QvJ4zsuU7+N1d7kMWho?=
 =?iso-8859-1?Q?ggNDgvU+zp22BT08Owv10ll/WTSo2/FjWPXfsF02GCc8VH6h6aSbCVlZnV?=
 =?iso-8859-1?Q?frBLkh2v7yo/JbbOAzxFHPnjJvAJYkhH4YonLZqT+qYda0nT0/t76rF+pm?=
 =?iso-8859-1?Q?ZwnA3bvScWhYBdU7qNTjdLkXw+b3h3D0BOF2ShZx1xc3vSdTyMN0TV1O5s?=
 =?iso-8859-1?Q?UbT255qScjo51VUEvSRDIruXUGY4Q3vneIa8fB04dvyJQUJJfypC8utDhy?=
 =?iso-8859-1?Q?QIXVeAF8pUXLRFnvonGi8TNbKJYrIy6TZ5/e4jOyq1bzY2JIXebiom4Pjg?=
 =?iso-8859-1?Q?hHFAJS/vBzv76eh+rMw6T5cUZd5tyEba9mcKXj4Xf9povkGWVfVbd9Yw4h?=
 =?iso-8859-1?Q?JOYIaFyTecA0vAkzXHcU+JQPzztTz8p8g9D+kTovfkEt2w61ux8JV9oIDv?=
 =?iso-8859-1?Q?Egt5xrjtqadV+8nWUXngZvzL4ykuSAXSjUOtbGez/slgqsDP4ek3DcedO5?=
 =?iso-8859-1?Q?agBFZWRjsE7+wyFTAAXZBrckk3VXCv0L1N9W+saBKtcJSYgSKD5pEwk9+y?=
 =?iso-8859-1?Q?ivBDLGCDk8OGRsqySl3ILPlf0Ub6vJk7s7GWWOlaQ57ogfFHoyOvS3Yu+m?=
 =?iso-8859-1?Q?NCj3vNvPygzjO31WFOk4BZeWfUa70V8SIUlfGuvhPbMl6lCyydu/d0YIrq?=
 =?iso-8859-1?Q?GMeMlAgo+jZ7/qlCsaaMfF79bg9oOAkfJc2d+4Dw4vzvZDkr7K07+DLB1r?=
 =?iso-8859-1?Q?ZB5ijLuzuH6tv/aXNYNS0zYBbARfdGMRtVqA/bFGlXz4/yXZCcF/e7G8M7?=
 =?iso-8859-1?Q?vI+Om6FOKp397eqXPDEYg5OR88BglX9lbbE3DOPm44IqMuwDMcuBdky+9U?=
 =?iso-8859-1?Q?NgLRXnNAid90VIpSYtTuEap71x3xPAS4G9NaEezFtuScgTzFEsm2Pm4gsj?=
 =?iso-8859-1?Q?a/wP3LO4vdTtFIak/ttvsbmr+YCt/5YhYNLNre3gmp70TzBStX7XaTQ0Fs?=
 =?iso-8859-1?Q?3S5cnpnXo3kfDUb+fmQYMw4Gs0dG7kvxvxvXTNsGB06HBePKb8D5thz7xr?=
 =?iso-8859-1?Q?Z4gJRt+Z19lw5K8nZetrr43g1IUk1VfXi2tgorPcPIIBWMsQCuy+Jz17ss?=
 =?iso-8859-1?Q?mezRdUyejrIjyBktffcFoj9Yb9YzbRpYH1PtDA3w36O4iebCGiUapTMMMI?=
 =?iso-8859-1?Q?xqwxLbotTw0ZRJbzkRhIMmgH27n3hvYrRkY9Udu7WU78Sp0kZ0DX/g9Evc?=
 =?iso-8859-1?Q?IBwVgn8VDQYPGeBjZt6y9zb+1GgBlIHfU3THCv5w9u4c2WUUMFxq5UGxEJ?=
 =?iso-8859-1?Q?BED5UJjCsPwtqTpBCbjf7wN8blXOeeoJH5L632l5k3UYqKJXSkr7UouXmO?=
 =?iso-8859-1?Q?cw6TvGz4R75HIsT4oWlJzmhzHf2k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nq0EutqqXM0EtGaOQouvmdzO84aWrcHn70FLiZTkWLK3XS/JhabJm8hzkP?=
 =?iso-8859-1?Q?oEhdaGk5hqoCyelAhOVkGsrVDyCtFInEC2DYSxWvSi5k4gB4/oLrjqX6sW?=
 =?iso-8859-1?Q?5pVpej3De7z76MgoQoqa/GvBKo6IfkD82mdsODtrVRDrqr3T7YqR2p/HrR?=
 =?iso-8859-1?Q?R+eyh9iHsc9EBe8bWMJ1ZjdsmNjXoTZv57aoF1zDNvkhHHRjFhb97s1Wdc?=
 =?iso-8859-1?Q?LBGmbLroAwRusW/aj9H8SGucOZP5nisKS4KlGWNASXRqx+tO4kJGh/7VyU?=
 =?iso-8859-1?Q?f2wOogxkKEwYv9ka0Oey1rIUywBHlxhhBULp02Enk8Pz+3wddkL6AsGeA+?=
 =?iso-8859-1?Q?GcL+liKknANA6pnJIjtkv3Wb8AQkvYPVnAczH82G7jQN2Gh4MLKH/G0LGW?=
 =?iso-8859-1?Q?gTQ0FvWfLaal7WiLAySwOkw0ZlyGY/z+FgSCTTV3hBpeF4aFPCjTjAd/pg?=
 =?iso-8859-1?Q?fIbPyZy48HlFglJYAxql8ZxPzjDKAn+QPP35h1iG3gty37MgFrVMeFPjoS?=
 =?iso-8859-1?Q?FPci7HyyL8Hp2qh8uKJp/jfkBM2P5kKRgUo4rKSROLaiwAfkiM9szrlhKl?=
 =?iso-8859-1?Q?ih0oW8yV7xecJKI4hYDyJpkaW3cbL1k9gtTCTCJfJjgdeTFjAKTjJzhxlR?=
 =?iso-8859-1?Q?fomBBY9u0Cr8AMkFrWrEUxH710S2utYXkBmxlgwuYmAX/zxH/mBnuzrAGD?=
 =?iso-8859-1?Q?GA1hNTHp3KIrsdUvqsEiebdvaoKhePD6XEHUviCuxiymBrwmmSEFS7XKT7?=
 =?iso-8859-1?Q?bHYlTw2ugMnKOGhEoYHC707ffuWkSbP7vkDNxn27eF2QlhbNM7fXcBeFyk?=
 =?iso-8859-1?Q?ttygSV8nWZ9SThZclN9kZEExo6lJhXy/z39zrATqZtPkdIRZMJBDcg/g3W?=
 =?iso-8859-1?Q?/Y8EnRoR5PDkJMTZlkzJ+93up4w3Qh+kgIsak4mDIkHmGsnLAUXwInwFR/?=
 =?iso-8859-1?Q?L/wug8MMyyd7WWhtQ2yzabX2K+m8DIilk84ne+MLr2g/2v9fE+78OdWPLe?=
 =?iso-8859-1?Q?h1V9GvEctJTkjxQGwEW76Fw2X3pkxq9t4KHBR2sU/mseKkkGaNghT5kYPR?=
 =?iso-8859-1?Q?D9rf5RarDYXyqJEsj2N6Bum/1ziQoeDdGAbbivWVkQDbWbNqefRCmSFVoG?=
 =?iso-8859-1?Q?wet65fy3fhHH4BqXdoabupc6yZbA3NnW9UYgUekEp92YAG6r81ntX8YDOi?=
 =?iso-8859-1?Q?4O6UWUC8qBiYNMqH+Zl/RjVrcaXKdvWwsd3Qj7lXGn7j3szQv62g0StgA4?=
 =?iso-8859-1?Q?+gcTeH+8oLSgOWLvpBt1/2NfsvLJeXwfwkdqRwjgIHpwh8NXvVOXiGbn8S?=
 =?iso-8859-1?Q?r4UqvFuxBtTeiHNBWg2bVBWV/QmAxibkJYbnKCdsMVWI5y8PJnosAcSp6l?=
 =?iso-8859-1?Q?7c6B00/UUCeDdG3826Wjf+jl/O2hLC2VaavvjqEJR/PshyFu2d8m+62XKe?=
 =?iso-8859-1?Q?EDkzJSnZ8eqc1z3kNE4U7FV9gnpVPs6LDkmUX1/lLtLhoTNvLG8KEI4vXI?=
 =?iso-8859-1?Q?orLIG6KNajjqCbZVO/qyzdpbuXen9fGvI3COxJNxj5CsQdzL3V2FXZVoWY?=
 =?iso-8859-1?Q?YxhnKF0oABHdGl9AONcdO2KcqwkYVTmTgtLWP5hvPEYh4az/gy1xB8gys2?=
 =?iso-8859-1?Q?xkS1nKIKYS0ymQP+Q8jWnJPJ2f+FY+MGuURV7FdPUBoy8UrzJQao5dEg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ac1fd0-e983-41ab-d8a1-08de34af27ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2025 10:06:42.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89AoRtGoe3QcrNjy6tKMhJ57yMayQmjcStS7VnPnoOwDlpLsdzUGbWkvE5z2NST7E7C8hHzTFoBrJpo5qj+qwhRPPnKsk28RrFHbRm+1CFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16443

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 01 December 2025 15:29
> Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
>=20
> Hello Biju,
>=20
> On Mon, Dec 01, 2025 at 03:04:08PM +0000, Biju Das wrote:
> > You mean to avoid unbalance between suspend()/resume(), we should not
> > do error handling in resume()??
>=20
> Consider the following resume function:
>=20
> 	static int myresume(...)
> 	{
> 		ret =3D enable_some_resource(...);
> 		if (ret)
> 			return ret;
>=20
> 		ret =3D enable_some_other_resource(...)
> 		if (ret) {
> 			disable_some_resource();
> 			return ret;
>=20
> 		}
>=20
> 		return 0;
> 	}
>=20
> If disable_some_resource() can fail it might happen that the first call t=
o myresume() is left with
> some_resource enabled and some_other_resource disabled (i.e. if both enab=
le_some_other_resource() and
> disable_some_resource() fail). Now if the resume is retried some_resource=
 is enabled a second time
> without being tracked and a later suspend (or remove) won't bring the ena=
ble count to 0 and thus leak
> a resource.

There is no cleanup function can guarantee, it will succeed next time in my=
resume().

If in myresume() any of the call fails, we will try to put the device into =
low power state
(clk off, reset asserted) to save the power assuming there is high chance t=
hat all the cleanup
function for low power state succeeds. Also, caller will get error code and=
 it know the device
resume failed.


If in mysuspend() any call fails, we will try to put the device into resume=
() state
So that it will report failure and next time it can retry for suspend() ass=
uming
high chance that all the cleanup function succeeded during the failed suspe=
nd().

Please let me know your thoughts.

Cheers,
Biju





