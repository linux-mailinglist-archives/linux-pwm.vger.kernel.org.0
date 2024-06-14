Return-Path: <linux-pwm+bounces-2470-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F8908F40
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D70A1F28E2D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050EE17BB23;
	Fri, 14 Jun 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tO95wlme"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2049.outbound.protection.outlook.com [40.107.114.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11715ECC8;
	Fri, 14 Jun 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379881; cv=fail; b=SVv24lcdD9GiJ0qA7T3D2XUk7BWsenvs7p7aKwe8kTeBiKOyFm73CglQTXEnu5CYqWr/h762Y98M32h26BO84TKdpgTG9hzD0cijvLgY3n8PESG3s/3eHOYSdyr0lhFjGp3XzTl1VcSUe+zC+HsjCKEB0ST5YZHSxSTm4VIO+Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379881; c=relaxed/simple;
	bh=T6VMriKj8RGFgSD7E9nkXbDRd5pD7298J2RLtKxBcGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d5WLNOhL8aQO7OP3j58L09E5SwlaqVoqgEPQaDmMGTDonzMyPScDatXfx98D55/Pm+RXeV6TrU1wW4Cxr5FftfdQBLSGZHXXldjqKc6RG429loiQ9orD1EPcJJV8Gwravynx20pdEce9+3bggXnMizbh2GORN73TjzEbf8d3P/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tO95wlme; arc=fail smtp.client-ip=40.107.114.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVb/5HOzYsDSwJm54cm14/jWahyeOxZuB+amoXYwh+7kUg5aSFPimMDdoHKbjOJxafhL+aWLqWYpAJURmazz4gaAlfuheqzsObDs/C2HGklJlsQlfr8khmqd336TnXD5Pz/WkSKgZJG3T52Glr+drLZyPpneKC/okk6Y8Z/z7Oehnd5WXs4mxobaGt4sFFQiH037O+WV87G+/P25UxL/I9/x/e9gFgLLSBMYAtKnULSfvRYcSSJYIAWptmr57xBqI1tx21zq97qxFY747wScr90jCfQF8PBz53xpObEzk05W04LQiMFdYZ+IV0m/w7GeSDGD4fzG4HwW0t92c4tEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6VMriKj8RGFgSD7E9nkXbDRd5pD7298J2RLtKxBcGg=;
 b=Eal81h9wm9JwKAO3HDtNe6Xc585iKkAKmOK5qEpaaBpPm0YNlX0OL5gK8RSH+CjdFcr8L15Xm7u8eo7tVWXJylenn5lJNYGnofzTM5F7gyQkVjjGbj6snRZ7vcN+vQYRfM3C9nn3H8MrckQZ+dL6i8nh0qydy8dRZHd9if6NWc0hjYiHqdQyTpNC64pGyjFPWxOs41P4XHl/eiC3/bAd09DfJR1qNJ7PN5+E2lPZ41XFHfjJgImHMnLWJXOolF677oW/URcWj52D3leuPRuNVMwfnKaYW3oDUUgOloOJnXLYzKlH53jwJ5Bs+XNy4I2yiszb3ub5ULO52SpRiv/Otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6VMriKj8RGFgSD7E9nkXbDRd5pD7298J2RLtKxBcGg=;
 b=tO95wlmeJzEEvavHnepyDyERDm9F2oKKDDz6GzMSAT0gFh6TuxXE0lIw0OKkS506W4Ty1FYHppGRzCQ30TIf/MZevwZvMFP6U7kL2yOZAn4w0KSbZkfdOjctaYab1er80RpdMTLTYwTHIEBuXNIQtsOcbBz5iL1XdYZRoYtAolQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11075.jpnprd01.prod.outlook.com (2603:1096:400:3ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 15:44:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 15:44:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pwm: Fix namespace error
Thread-Topic: [PATCH] pwm: Fix namespace error
Thread-Index: AQHavm1Mj/YQW2ZevUi6CAyrGAK6j7HHYlGAgAAEBNA=
Date: Fri, 14 Jun 2024 15:44:27 +0000
Message-ID:
 <TY3PR01MB113466693077CD17D73AE7D4086C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240614151233.398463-1-biju.das.jz@bp.renesas.com>
 <ld5tegce2dpiehqg2offdyrazew2l2vkq3unm3fe3l74lyufg4@vnebm7soytym>
In-Reply-To: <ld5tegce2dpiehqg2offdyrazew2l2vkq3unm3fe3l74lyufg4@vnebm7soytym>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11075:EE_
x-ms-office365-filtering-correlation-id: c1b13001-305c-437c-9932-08dc8c88dfa7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vlxS3dpjsf0JEzDQ1Du2Qh2cCTLS3sESzk8jgC4USp4p7o9gvlhSI8iK85?=
 =?iso-8859-1?Q?lxsQ9P7IbLCDlla3TndHlfESpo3nvxLFtJYqDZfrluImbvZIXAj63Fc1ES?=
 =?iso-8859-1?Q?tP4rNs6SRRSk3udutE+BN+VxDegnjtwjzUVkClJSEWIi8Lheo+3f9YrNb+?=
 =?iso-8859-1?Q?OyQs++6Ak7MxVbLnvi3oNWvxkR7rsGDayYmsBhRJDeWk0b8RlGDLFS3aEX?=
 =?iso-8859-1?Q?0u2hWN8oJx4IeFziPPjYOdst2Yh8oKGZVQat8izGDm8aerSmtwluNtgWpR?=
 =?iso-8859-1?Q?M+ptPF7sVfdKhR6QIRZ2G1p+a8+JCmgPPZsWDoiroE4ZQEGTMDIQ80zdPX?=
 =?iso-8859-1?Q?cEKy35otkTmWnWBAv/AO/XB7Z/MYMvVJ5i//PVRCWX1up503dQeQfLA2fL?=
 =?iso-8859-1?Q?W54gYPFP3GAs35L2hDvGwDOfb4pgEyn/x7MMk91xsyuRHKJLzrlDa1hf+7?=
 =?iso-8859-1?Q?72qWxPme9nR9khuzL9xpD+8oIAgxhoY4/l7iG7TPn+dAAqQtv7NNYP+GMq?=
 =?iso-8859-1?Q?L6X0eZrMJRL5VnZ9o/ZkIE1zby0EA/jYdxAhc2G5Umg0nV7LHQ/jDysVfh?=
 =?iso-8859-1?Q?G9SvOVm4pYNcngfli+e+oGVBaBBfheAP5LnBQ6qKfcbuPNDFhggSE1YAV2?=
 =?iso-8859-1?Q?IL5vBaBPcUdIRDIdddg+xwnzyU1uZ7MXxIh2BfVaapUvEtvuSslmefUwpi?=
 =?iso-8859-1?Q?JF7MVZfLF/TrKCs0ihVP3yZnRNOBlGtnkbJdwNZ31aTG0U6kjJtSP/9zXR?=
 =?iso-8859-1?Q?Ef17OZOkas1Sta61rRGs/ucaMtQ6EOx7BwVF5xiBygSl28q6GqYjDogUx5?=
 =?iso-8859-1?Q?XHkAodSXxD4yzpLDtPvzPTbhemzaYXua3X2B6p3szIZPYy/nHBMzKRVqpG?=
 =?iso-8859-1?Q?uJGp09fAWSrdduPiTqkFsxm7DMOF/dI7y5P+CKZj6nM2P0hm0iM1nFCmls?=
 =?iso-8859-1?Q?ocfeh/k5TM6bGxTBVuUUxa4YFl+rdIOoD30lq4jpv+epMZVG7D4quUl01D?=
 =?iso-8859-1?Q?bkiYnmnmPovM6cWfS1oC1FqJ0ebVF2ROzwV1NDp82h2tn/vi1NwDBWyxFm?=
 =?iso-8859-1?Q?9Ltm4TQZvetGKAbE605iF5/oTVOm8SWo2JEltbqd9mw/z59fI6P73elwq3?=
 =?iso-8859-1?Q?9HCPudnKrkQY21ykiIy8c82cxCCNuPN0wdIxursQiVsg86YUeEydycwmpL?=
 =?iso-8859-1?Q?tlleaCup30rMrrXsHJ+cmj34ng90Ml9ZtG6YFy1RJ2yziV3oNL9h0Y0jce?=
 =?iso-8859-1?Q?d/fJfSeTpWDweXNmt3TskwAuHkMGDC6kL4JKq1XvFwsxDAbJpiZU8CtwR1?=
 =?iso-8859-1?Q?8R/wMaOVGOK2p3LbDO5MUBQ7beltv5ItZ+OTqE/ulQ5ZvX8bzXoNQPPR/s?=
 =?iso-8859-1?Q?TAgwsETVyl9Lz+VbyU3VSXT7s85hovI5NCPaOQ/WLR7XIjIecMg6A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bBj4d6lpR9txdDS27qc7J5EDLFq5ZGh8bCyqdctvR+jTpZoEVffQiNz5Go?=
 =?iso-8859-1?Q?N+1anruUeRH94JxIVRgR8SM+vDFjb9xVvdhxbRNDqFy2E2FCX5fdNXnnNo?=
 =?iso-8859-1?Q?YnI1HsHf6fSc7Bf5ZOk0vdImRJr0Qve/cvP9xMoaFv2y9f83S8p8wvzUpu?=
 =?iso-8859-1?Q?3RMTjIkNmLIXTYmqQH6Fkmm40azZm0YvQnSP1Pa4mxlZbepO3TjJx1I3di?=
 =?iso-8859-1?Q?9ScJVDop7/s0YifKUJKZo633BQAh/ZbLb++u/J+G9mFtQ9ZZDY6b8EnJex?=
 =?iso-8859-1?Q?Zr1IMKSj35VK5jAZzqqgH9IQK3IdHhIZ/kqHruIqKfHlJPC4qFz27b5kz2?=
 =?iso-8859-1?Q?OqAbCh6Ws3e2hapu9TPfSTOFsahlDgywWI8x90j1fOd19OIdQ4d6JQesB/?=
 =?iso-8859-1?Q?GkorGRxtclJHoYCFKPkZYKL8qgeUJSgzQUAiOEqZBYpdjYQn+9Vngi3Rm8?=
 =?iso-8859-1?Q?Lw1qPvFTcPx1q9eyHWLjr8r5W+nu9a+JOL+dR4BVyvfzVp+YGiT17VzN8p?=
 =?iso-8859-1?Q?qEUicryhiJY5mx4OUz9MpFaYrZmRMg9pWPjChx5jMhTxy4f0Jb6/bm/Aos?=
 =?iso-8859-1?Q?M+7xKiZFg7GZ4VZkMwQblO9SYHpdqcL7g+8mxa97+E8W2KkQaNcKzz0YBe?=
 =?iso-8859-1?Q?AQse/2wEocRCa8sOMNKQWpmB3mj/8MFisZGcO86Kt10bZ9Fyqq3h6AxqjK?=
 =?iso-8859-1?Q?KDTozwRWOhYsl+AJB4u9MOrJFO1j2FjORhWpVw332EMMseiSG1jbm636Md?=
 =?iso-8859-1?Q?uuLxqX8wp/2ZMPE2Uzn5hbIbV2Cv8rCj45j9wEZSHJd6/JboBdpOxlSbCK?=
 =?iso-8859-1?Q?A5o/qxBgxN8sT31mHVI23xSTa8Vep3zW0wjFN70xkOw5dQDc1PPT1tziI/?=
 =?iso-8859-1?Q?nmWBRKaHNNtDclQap5bWohoQn+bbug1Sy1RLyv/NhF9cKAH54zX0wM7f56?=
 =?iso-8859-1?Q?o2edxPXNPwOPU84BaLLAnIdbtx0dqNsYUfk0ZPHT4e5ixY/Sui/qeNrkz3?=
 =?iso-8859-1?Q?Bw+cIVDyqvH7NjyWZZMpgg6Ezt7co3do429DmUi0WeL7tgswNs2RR2Ru/P?=
 =?iso-8859-1?Q?g4c8AVE4v5uCIf4M4EjvIo3+sdpai5Oqa+4JoU8w3A/1Ik5rQ+RAGH54EB?=
 =?iso-8859-1?Q?XlCNhxxPLqHjIGE2LW7pEn8gw4KAjYLeqLhWx+/5II6gUJRgabsdm796In?=
 =?iso-8859-1?Q?zFPrS72uWHasEHUzKL+r6hEFd5QlaM/XT+uqzu6p6WBv4caprFifqtUXIh?=
 =?iso-8859-1?Q?3xF2R1wnuu+kzRmS+UI5LA+EgaQMixo/ifL79TP5Uer+rACOcois5CPf7i?=
 =?iso-8859-1?Q?i2XMmfI+TycZ4Qpsj2jWAej1jwGecBkfr6MZP5MTWcjb3tN5oUFpRg7iWt?=
 =?iso-8859-1?Q?cGf6sR/3lHJI4CdPjpa8NnFQzt9YaYVNYuv7+1eouslqmxXhs+GISr9SCg?=
 =?iso-8859-1?Q?UyMt/RYoYmpti3pM+5OHHEqgQ4KMyycb7xw4MYJQazzNCM1U4Zn7Yo/53+?=
 =?iso-8859-1?Q?QNthvryPQzoq0DoXPOaicgoY4NzsxZrBleaVKO+th+LH2RTUUwRtUy2w3e?=
 =?iso-8859-1?Q?VmqSvm7qNn9EoSNNxrxAqOx8lJGY9b7/sMlz4bJFE/ilIXzVX6cIxtLBd/?=
 =?iso-8859-1?Q?/ppFw40kLTYXPJ+TqSo0SaqpRT7Gt5LUUY/ChrDIGYe+G0Jv4AWHcciw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b13001-305c-437c-9932-08dc8c88dfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 15:44:27.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bID/lGQTA2ZvcXZ+nlTw/Uu8bo9tpc7Ye3MHWrM0Am2i1cBUW7JZceCCH2DtCLWAPhIcj6jqB3Cl9t6Zp/2HIV13WLr7Pfl48wvNN04KiOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11075

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Subject: Re: [PATCH] pwm: Fix namespace error
>=20
> On Fri, Jun 14, 2024 at 04:12:33PM +0100, Biju Das wrote:
> > Fix namespace error due to typo by replacing USB_STORAGE->PWM.
> >
> > Fixes: aeb9cedc87a2 ("pwm: Make use of a symbol namespace for the
> > core")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> I found that issue locally, too, but obviously failed to squash this chan=
ge into the commit. How
> embarrassing.

Yes, It make sense to squash the commit before it lands to linus tree.

Cheers,
Biju

