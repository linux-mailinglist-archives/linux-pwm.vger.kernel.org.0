Return-Path: <linux-pwm+bounces-7321-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B97B577B4
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71D734E1D8F
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E32FC86A;
	Mon, 15 Sep 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ntqEJEz0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2051.outbound.protection.outlook.com [40.107.114.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2979271441;
	Mon, 15 Sep 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934666; cv=fail; b=IydsSQUvaDkqdXAfQSaL/eBd/y3m63ed1BtEOZZOH2qY3eCZeMKoo7p1sTJts2JmckSC95ZYAFsZPDGKuHmKFa3wNWqfRmY67BT0hH0o1JgLs69vXyVwnIk3S/0Ms/f1HZM4GucJrcQU8q4YdJPzXZz/rovtndBM7p8zeVezcDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934666; c=relaxed/simple;
	bh=E4ssCUWzM8mS1QI58ay7ejOXFHutO6budBhvuF6ZOsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDxgbx9NWMxH9E1RXjS6aShBXFFugoFpliwjLVhCIOiPwlJz7PKl6GyT3cgjTagtNEHFlrgtesq7TRtXpDFfWGmuW3Th3NyuZ4uNTSSyQP0C/FhlA0gwdEKkUoViaWThpAxM2+f3gfBqMW7OIK6Hm+hta7erSxTBLBTu1ktYOuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ntqEJEz0; arc=fail smtp.client-ip=40.107.114.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynS0bn0xsvk7ILbvfOOY1c2m6DK8zpDN0EllPzJ3+5EFJxC1Bpj994fEyGl0VkZEFtYE5261RSmKZb36fMUPG53LELlzkAjVJlJLBUza/u35aeihk/LKv3OpzI/3kLNPqxh1AEsvirhfGPSWUzWYAs9ZjSPVEtW4bqgCJcsrxIvU/w7eVYHYdXSTPF7J3ZFUfNXnjOWwoO6IEngqEydmtYuGxcU5usmir79MBFFOdgdqIgB7yVh+iO+YMXaBHSUD3EP9pbXfcyLZgU9kQxCBNWDIwFxnwwX2EiJi1lZhnw+ngRZwR81hsLqAwV/g4/7AaK/qfiSxVZm4JR7g3jZIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7W+LtEiHKgLbGxGRgnEQUQrAjE4z1LzfE1UByC7ExU=;
 b=DT2u2qr2zL2pZ46j0hB0ix1oBeY9zSB4aPdWzuvBOqNmQ6EbYn3YD9Kq/F1nDupk/tipqbF3j8ykpcMpR4xCG59P4gDPB/6Ht1TSl6LZFkERDRXWyJcMIVDq2nPpebVhh0URkhGYgtGVr+8wS+XzIz5xQBJ9sEjBRptrvxGQXAVEhD4yfeSZqaAu/5+4k0N5kZkJJFjnRTNyMbuKVb1by4KNNmMnnVxnNXpbm3QtD207+T/RgSejyhpydvpAvo9RHeP5Ptloc8RqQcYEimNijASFOAwGHMpOBBiOXmUMBB7I/arGzpEij9XbGIpTUQHe35UXZLNavqGsAvImpBiIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7W+LtEiHKgLbGxGRgnEQUQrAjE4z1LzfE1UByC7ExU=;
 b=ntqEJEz0Ywbv/TYF6xaKTb6OVDYnrXHiUdDpYqSx56FkuOZst790DhdekJGqNEv1VkbtYy1MBtcOv36g2mbMU9HybUQ8Zk9DMFIqV7MqkZdf1tNcxKi5Uhy2OnG1DpLpiRG/9fdsetY3xeFCE8OXZFYqVgPTWNnEBHXzsvU3Qu0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10257.jpnprd01.prod.outlook.com (2603:1096:400:1e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 11:10:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:10:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: biju.das.au <biju.das.au@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Topic: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Index: AQHcDRGiT0WyQNvV8UKYMNvCoc6mn7SLIBkAgALGPlCAAcIaAIAEn/Rg
Date: Mon, 15 Sep 2025 11:10:59 +0000
Message-ID:
 <TY3PR01MB11346DDBABC31DBC7F94724F38615A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250814115022.73732-1-biju.das.jz@bp.renesas.com>
 <jb6vcdv3553kbvuzuxdmx7tyxcpmnkaqszks3n4apmt43an6d2@mr4lyezd5a7s>
 <TY3PR01MB1134600B9DF5AA79AE121CD148609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <6gvpdndagee54h7gr3uqm37rfu4yk2owffxwtszyjvnic2vqvl@pbp3jqcfrzox>
In-Reply-To: <6gvpdndagee54h7gr3uqm37rfu4yk2owffxwtszyjvnic2vqvl@pbp3jqcfrzox>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10257:EE_
x-ms-office365-filtering-correlation-id: 800dc707-9fe4-47f8-3ee2-08ddf4488cc2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/dzDhVu7Z1BxrunaNzXXgERotrIQpkNg6IeQBf+o6gzCfKGNom30338Uta?=
 =?iso-8859-1?Q?Anl0fceA8z/l3+kTr+8bbOiQ9Cn9GxA9wKK2MtsYXQ6aTY98jJpL4YA7ps?=
 =?iso-8859-1?Q?h1SQ2bESXULBG+yYw26nmbJk+lTzAJepVcuMSwk+A68sM0EEgtM+SyO/5l?=
 =?iso-8859-1?Q?a8NqZPptpDi4R+4ms2bPAtiv/P+Wh89JP5KsqNkuuejU4rH/YlmkjZWMBz?=
 =?iso-8859-1?Q?gxvjKYQymldSMPQucv0XbgH9qJiMxU+FnHs22MJoK/aWPy4J8cYkrUYKQ2?=
 =?iso-8859-1?Q?x07YNIpfzKrEzR71yLE2MFc5inBz2ZIcGxhAI+4CvtCpw9CpWQfZHm922+?=
 =?iso-8859-1?Q?Y5I4lgx7dk84GEnyn67du23GiXprXfSQJcpwmraUkvDlBeuGo09MeACaSG?=
 =?iso-8859-1?Q?H30eCzLPq2FuCYmjQZwcZtB5U4LDO3lfjIys92QAe51xFsiHk5NYvhD9vP?=
 =?iso-8859-1?Q?nRmE0/0QM9ElSb7zL2eEkKDxtd04uiVU6aNbnZJCFW7NFKLeZw3So4aGxp?=
 =?iso-8859-1?Q?OkjbMrPC8FRusbM7EjzPdZW+UffTry6H4a4H8KQZDfUg9a+3xZ3CaQdY5V?=
 =?iso-8859-1?Q?slaVGzBHXHMrJGGa96L2I81h7Vx2eXo+amUZPDuUTfGwFoBd5REJOCpktq?=
 =?iso-8859-1?Q?sRKl+e1tm3jmOCGFBMx+66GN/9k4L9eE4yW+rzcvWooGK7+4MrTExhEEAE?=
 =?iso-8859-1?Q?3y7udeE9UGq24H3aLvAGW7Y0g7lR2zW8vuu8LnwrKp0dHlAgllE/jKKjGZ?=
 =?iso-8859-1?Q?gxgsaG1Xh++phKxHuFTOx9zqM6e7utlt/wb5n4No6QvecrzwU8B7iDp5fG?=
 =?iso-8859-1?Q?KAfuVFcvwOBdCIWH+ObHHX79iXHjrvtyhQwyBIqXsQOIRgHqiM/OVr2jpP?=
 =?iso-8859-1?Q?sA+oXOZt+icnuLGseJoHKHtcbEnkIL35SR85pZUYSQYMD3W8ULflgRXt+8?=
 =?iso-8859-1?Q?I3MHklCcEjKHxsahseS5ec+f7KNpHPqjWb+3J5BaNI4iLgFm6JSn850tXm?=
 =?iso-8859-1?Q?qEK03krS+P/7qGnnJ2IAe2Gq1KhzhV18RBg4HDDl7FaEhva0+uQ9lL1fmZ?=
 =?iso-8859-1?Q?pz24s1GXJuYw+Yhk+yLE/b+llFSeDn3XCiFkgOf+9uirwr43Sxx2MOwJ+i?=
 =?iso-8859-1?Q?WYQ+pG3lBSTlukFPcxcZrJFwFwldaSx23UlbUkznnq1kqgY3zlNuuvvh2C?=
 =?iso-8859-1?Q?HiJCUzW+Ng7YyqM5nl8bVXt0F44rUe7YxTyOA/3MNtITo0jikt5yeuljpZ?=
 =?iso-8859-1?Q?fuBDtBPiEGrE5E0xVHZK/437u5li8c1iN2lMF3Pl6TY5abMUjzQ1rHn+Rt?=
 =?iso-8859-1?Q?6lLsEb3+4fPoHpsljqONoT9XzjeAMJouCp8ijWxwiP7AuUP8xObR3BON7I?=
 =?iso-8859-1?Q?lLu93NQFQ7bmAhjzjclKif6J1Q7k5EUEVt3JO5qgSF0/VlFuz+a7AZrRvq?=
 =?iso-8859-1?Q?FALPoSzkSoh3rP++ZBdURB2mDZCT8LZZ5sJzXgWXf7WwNqeZgOxsS81R8d?=
 =?iso-8859-1?Q?/oZ8007P3bKdNCFPB2RD/R1PoRnOWhcCSJHujjn35E8D8Dh+gI00NsTBXJ?=
 =?iso-8859-1?Q?UYADsCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jfF0t4e5EvV24j43HvFjit/TmUGjFAEtFpEh9/DXfFvB/FX+p6jq+z/70Y?=
 =?iso-8859-1?Q?KoabD4J2cYcbrOvz559XI6D22maM5qvWvpKwFG224Qluna5JHSyCpa86e6?=
 =?iso-8859-1?Q?lfQl4i4UA4oXI3UNfxE4PRlWT154Oa0j2z0SaOPZ/yQySVIpdkiU0gx5sp?=
 =?iso-8859-1?Q?EmOeF0Z87avgYpuqg+OnksZcvc4Hsr2Mjde8hJHEPdJIktRrZIdxC0yEJR?=
 =?iso-8859-1?Q?7hoBusPWbAT4rGAErKzDfqbfuMVOlqrsbu/PxlpiMFOL2JssTSABCkiiQU?=
 =?iso-8859-1?Q?I5RO9bIPPNT6pIHj04TM384FOgEtBMVUgMNxciuD9VWkgg3LDl5VkAxvwU?=
 =?iso-8859-1?Q?uI+k5Ek+SKNvBVjkVUyn8/BtTWSrL0n3fVHEVDYrheVqkBPFw42f9Ks4Of?=
 =?iso-8859-1?Q?R7W0vzkZvHagdXLEv7pqs3eZUuBxELiCYMEi8fpJ2Eez0tYVFiNb8pcn0g?=
 =?iso-8859-1?Q?/UfhOIdl26ZjOPHqs7AEr11+G0afz0ML7b5axyyzf7whYr5FgjJcqUIrUX?=
 =?iso-8859-1?Q?4o1aRVtMZjlaIQLtt1dFLE/DqQlW/n2WEiaxG+OnuLo2uR1n3I3STJZAr8?=
 =?iso-8859-1?Q?zrVmClqwmNYOHaGWEijKQo7pqze2XYHdla2Wttt+S959Fgfrlfxsmdnn8t?=
 =?iso-8859-1?Q?+OZUGRTjgl+h0Jiwcsms7u6ykiqDkj6SDHIIf/Aw0CZKAQLKRGhSolEfal?=
 =?iso-8859-1?Q?ysN6hSOSOi9BicQUqAAv5zDiJfNty+PQlcDzRMY6NMGYjMgJwyuRzI0VU3?=
 =?iso-8859-1?Q?hzqXLmm6FcnBLX6TKh+tnC5y6+i8dcKkRqIodRZGKl5NouDiXlgcFLXWZv?=
 =?iso-8859-1?Q?cN7LyjG2/Vy5KtDD8ZY0qUSnyWuH4kdjOyQ4KFiQhIDsLF8a+sAR+GfL/X?=
 =?iso-8859-1?Q?5/aHWqN5dU3ZhXJngUhq53IkuaL+fXYk3/dlTqTWyfagWNsOnfP5BQmuLS?=
 =?iso-8859-1?Q?laytk+SHlk3Ofe/1sSnoouAjB5fkXXafYsEF6+coAXEvG73xh/N7gDiZ5P?=
 =?iso-8859-1?Q?PUQZqQl9X6PsAwgtgOgit00HPXuXX/DmBJhHkD2Yt1i5HRyZDncQk2UJvO?=
 =?iso-8859-1?Q?cmLwUJxDRinaJ8TqoSWChe4jaGzIi4KrgAaJhSg6olyEc7XTNHOiMhI3Ab?=
 =?iso-8859-1?Q?yZ2G5Pq/2Zu3lwCfw2WkShJvCD/SlN5/SlFgax1MuVYPHPgYHKEQQCSOgR?=
 =?iso-8859-1?Q?nIqBm009V+6vgeiZEu0XqG2JPqQOEN++Oq8XdNrbyqSXRUwS7Txl+kORSh?=
 =?iso-8859-1?Q?9wi+VKPTUrSaajP8XXR1AZzkJCaGVBe14PDnYS7UB/IFTB3wGFCCxJoOYN?=
 =?iso-8859-1?Q?/pIf2/LZqA46SHCY4wmmQqGBs22w4TXNGfYwBn4wPxcKP0FqsONRriDJCv?=
 =?iso-8859-1?Q?sgWrvpZMDBmCUbJHbcjd6cAnY1IWhnPNOiT/R8D4kwHKsiyee4LMfZ9KzN?=
 =?iso-8859-1?Q?wBz2F8aX9wAOCkwNZHtJP7I9zrMnRVckr5G+vGdZbg4LtmmaDDgNbnSLDi?=
 =?iso-8859-1?Q?j/3DXo0OBTQ4utAcvOWd/0dS0LLPKqNd0nDzv87lHOcKFY7wwz6dgRCnga?=
 =?iso-8859-1?Q?GQY3P1ZEWk2pG97deXcFdj01/MtXZTPHgyDxdVqWP3qnVqwC2igdkaE774?=
 =?iso-8859-1?Q?HGA7tkMLyTyMt51cHbofopDog795SmeLqmNZ2X9OygIF3S6XftX7BwwQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 800dc707-9fe4-47f8-3ee2-08ddf4488cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 11:10:59.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKwd6+xoGUTVveN2+SqLbCBAZLoxVct3gJbZsTF1TnhNYbSlOqhD4A9GjvcQMg6PW5ymkMO1a/8Oo8SO6CyPsDd5HFPvfbXClKwlrUdfyqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10257

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 12 September 2025 13:32
> Subject: Re: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform ca=
llbacks
>=20
> Hello Biju,
>=20
> On Thu, Sep 11, 2025 at 09:46:38AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > > Sent: 09 September 2025 16:19
> > > On Thu, Aug 14, 2025 at 12:50:20PM +0100, Biju wrote:
> > > > -/* Caller holds the lock while calling rzg2l_gpt_config() */
> > > > -static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > > -			    const struct pwm_state *state)
> > > > +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> > > > +					 struct pwm_device *pwm,
> > > > +					 const struct pwm_waveform *wf,
> > > > +					 void *_wfhw)
> > > > +
> > > >  {
> > > >  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > > > +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> > > >  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > >  	u64 period_ticks, duty_ticks;
> > > >  	unsigned long pv, dc;
> > > > -	u8 prescale;
> > > > +
> > > > +	guard(mutex)(&rzg2l_gpt->lock);
> > > > +	if (wf->period_length_ns =3D=3D 0) {
> > > > +		*wfhw =3D (struct rzg2l_gpt_waveform){
> > > > +			.gtpr =3D 0,
> > > > +			.gtccr =3D 0,
> > > > +			.prescale =3D 0,
> > > > +		};
> > > > +
> > > > +		return 0;
> > > > +	}
> > > >
> > > >  	/* Limit period/duty cycle to max value supported by the HW */
> > > > -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->ra=
te_khz, USEC_PER_SEC);
> > > > +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns,
> > > > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
> > > >  	if (period_ticks > RZG2L_MAX_TICKS)
> > > >  		period_ticks =3D RZG2L_MAX_TICKS;
> > > >  	/*
> > >
> > > The code that follows here needs adaption. Other than .apply(),
> > > .round_waveform_tohw() is supposed to not fail if the requested
> > > period is too small but use the smallest possible value then (and ret=
urn 1).
> >
> >
> > You mean something like below
> >
> >         if (rzg2l_gpt->channel_request_count[ch] > 1) {
> >                 if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > -                       return -EBUSY;
> > +                       is_small_second_period =3D true;
> >                 else
> >                         period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >         }
> > @@ -272,6 +276,9 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm=
_chip *chip,
> >         wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, peri=
od_ticks);
> >         pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescal=
e);
> >         wfhw->gtpr =3D pv;
> > +       if (is_small_second_period)
> > +               return 1;
>=20
> Just locking at the diff: Yes, that looks about right. I guess you also n=
eed `period_ticks =3D rzg2l_gpt-
> >period_ticks[ch]` in the is_small_second_period=3D=3Dtrue case.


OK, will send V3 incorporating these changes.

Cheers,
Biju

