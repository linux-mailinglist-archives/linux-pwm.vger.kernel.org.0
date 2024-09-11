Return-Path: <linux-pwm+bounces-3217-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED0975D05
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 00:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC772285017
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F01BB684;
	Wed, 11 Sep 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HAg1oKx/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1B1B251A;
	Wed, 11 Sep 2024 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093157; cv=fail; b=hFALqBq2YNTlxV599ME6Xb6xLa2uTz1Nhpv6xp3fBdJ3k4R09jAGWtXEAMq2KRENcFinTB9DPiAzkkwEdt8wOx4hXqzQ9ZIFj3V1b9YcleI/QHzacfHFKFLzIPaAPUVQq44EVb4X3RX3fAdLRgv+weHh65VssfQivBXwZ9vWURE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093157; c=relaxed/simple;
	bh=UVP3bzbNwazemcoAUEU91E3kLwUJDIFkaYlQWWwtBP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBhHDhi17exJfhoYox9lOw5wrh2FtoLct1alMEfdoVs1QqgocWnXGp+mIwXCt1bU8G3vFVQ8NxKovfOFYEoccxKgSQrgHgBeu9eic4UcnkHyzbXEBqCimtmheys2Mp0EYCPyxJpGB99beG+h+AzBYH+nyxU/oBKzAcQrZAjRpas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HAg1oKx/; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6PSWdicMG0ow9CGv0sQ0wA38rJzf4P76WaGMBXvLude5It466G6Zw79x/4m3HRNezBnO7nlX3oGHEJ8vN5kCdSzaH43+7P4vHy1lnIBcSjyDfLExes/dyC/+rmBP+mGnz3JBLzeKs5sXC2Yqitvn2FB7FwD4rib1uZOU2cDcRlxAxcG5rgEQWJz4RWnbv5DHYIxxtj061JA4vLDKXmo7Cp6n5Nb6EsIkDXPdBPH0vjiFfb5ODcnP7dYD1fX4jx1+qhzknDxx45mxDVPp+CDZcmkv2xaxmG013bz6QSxz4zj7m8SPm30DBadEMdq0lLWYCZDV1/x9LLg2tTx7uHQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVP3bzbNwazemcoAUEU91E3kLwUJDIFkaYlQWWwtBP8=;
 b=jWJoHFRscjANdCDz6XbaDR6gR6bkaAaqkCvLbMQ+jP7K88Iaj3TXUdrWBc0TT6mqQNfRAVjhVagqmGLTQYY2XkzHuDgEJSw+deD5LdWxfIrXNt8sEVUcRp2UfjE3Z+xt7hb1rdpS5zcJU7qgkYyBAMkArZ4QPP4fFRgXrhRZlP9IbWwEzP2bLU5hj9UKzJBTF/tMeojm+H7MfOHZunBO4oW5KijrPD3W/en6TR8UkfDtEqIFIuUIM0yNzL9s36M+Ln5P7v9rnLcbS0KKqsJvtOqgOIxRdSJ+xAib7WtHC9G4I4Lv1V2ZPO9C7Eo4kzW7C3kNTxfuDkiO+mn/VP2xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVP3bzbNwazemcoAUEU91E3kLwUJDIFkaYlQWWwtBP8=;
 b=HAg1oKx/pcPYCO6mvZNwwn6ITdzUDc2le4pWLQZLCWimwNaJJOTuYF1CiQPRViUDsUV5HUhjhoVyfK85Hrga5gtcaT6zfGSmpz6d/aGiLcKfIvRFR5YdGP1XPKOs4CX3N1Is+eqB1nPPLE3DBaHXUskYsWVg9TvX1aoP1ZIfIz+tm9tFbKPEpKFlytCI0SYkrXFbqDQCQmouk8l7eFujnx/54nPT4s8a6ymEcj1PPr4I+ZqbB+fKNk9G0Wzd84qcrBy17CgiY66kXDQTROjLTJ9MO+hlrPqTrR4FNNeg9HwWA8Jv7xQ3FrxvQvvoSFnk2YKVJolZoIIwv/r3MQn8Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8180.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 22:19:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 22:19:11 +0000
Date: Wed, 11 Sep 2024 18:19:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pratikmanvar09@gmail.com, francesco@dolcini.it,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
Message-ID: <ZuIXVTk4q0eA8L7H@lizhi-Precision-Tower-5810>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-1-fbb047896618@nxp.com>
 <2ede9457-8102-47e4-86dd-5888b6e5b8e6@denx.de>
 <ZuIHLRhOjDOouWD7@lizhi-Precision-Tower-5810>
 <a34ae0b8-ff5c-415c-9d36-1f94fba99243@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34ae0b8-ff5c-415c-9d36-1f94fba99243@denx.de>
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cbbbf4-4146-4431-0f99-08dcd2afc308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qbynz7za8VensKTy0xhwuqQOstWGvfkFnf0vf+k1w8zZX1FqKd6JezTLV3/2?=
 =?us-ascii?Q?ZxufoW/kAJr6lhZxS3z26NBl6j+KT0r5R+kzKBxTVLbcRlu996cirZCgFWYt?=
 =?us-ascii?Q?zrMQtOht2imEVkCASRoXyxQxwexKzIVDWMy8Oltg6jBKYaaMB2niRBkVxjli?=
 =?us-ascii?Q?wup6hbWf9ZzBe5oyIKVHK42aMVvwfR6P/I6e9QuOO2xpjS14HBYLNsHI8LqG?=
 =?us-ascii?Q?MnI/0eYuDfAq/4w/YNv3B0lwgohsvWoRxR0O46OtDPccMPe3qZh7Xr+P3cU6?=
 =?us-ascii?Q?zKkDRPCmEC/v1oL4TwjZvA8AVdelJuruUcOXOXKs3z8sk1YFH2YAs/yz0LVu?=
 =?us-ascii?Q?e+bw0MmWUT6RBdzyBSsdFk5pW1acr+7hRxrc1Bw5BbEoB0LN2fVgSxpOGgZV?=
 =?us-ascii?Q?olTsDgKIJuQlEHUam2dHzNiW7OKkkYhNLqVmbqlfw6vE9D4VF6edhU6esqtC?=
 =?us-ascii?Q?KYwZ2vsDCXcO7k+VXj154rf+s/FnHRvtupiuOmeqdzXhetrHtN9Xgt1k1QVY?=
 =?us-ascii?Q?/urkzYheCwf83ETvzwC2Htjblzkg2bjl/OoXE0FYrWD56UBVtoG3Vq0DZTmv?=
 =?us-ascii?Q?TPv1GgUAEX/TFspl+LgBsS/b79NLxiPxxNvjlcm6W9bGtuJ1HYAeYVBEhT7j?=
 =?us-ascii?Q?gUVC6S6D6iYvfQxImsaYjDwp2rQEg75et519dq6QAIwxB/S8LRbvgnw1e0aa?=
 =?us-ascii?Q?6e2QY9Sx6NhefOIt4WZExZH8IAvg2AqRobcDxU5sEjkIFocNNSH7YUjuyC0b?=
 =?us-ascii?Q?fuwtWqRqs6uKr7cP1SXKcD1emId6RKo9tXhxsuL+3SylDg6RxjqzL7UhbT3N?=
 =?us-ascii?Q?YS5io06HoYAk3NkFTyzca5g+nh4kgZuk5aepF4l09TLiwzObpJmLoptv3MSv?=
 =?us-ascii?Q?tcC9kjybn8oL1e/jiRzxIp+ZlpcIKeoR/7c1fGHBpS3kXrXvf8rF5r8/NyWC?=
 =?us-ascii?Q?weUOBCH+kReS5etTCIeaMNZL83zrEfK90VTrSsqZaAOMCHBPDF2mQuAa3bUt?=
 =?us-ascii?Q?7GeR8svyCXwdGdUWs4/us+fgYzCBgbVe4sLckmTlO3LZYHuuCM+fxSSUJULf?=
 =?us-ascii?Q?HrzZjUmUh54HvdACm5YvJmm8ia65ckelqGL9t6Pt15NAuc3JhJEWSvnN9zLz?=
 =?us-ascii?Q?hGY1vwD41lan2zzQ8NIMqid3R1rWpycwTl5/uROqJ8sPWaq7U4gPWqxfxRm5?=
 =?us-ascii?Q?Wn4kVMp3LUUoJYl39SCFOlefVKOEFs291LI74b4ry9ee7NBByxveUkV8dtI+?=
 =?us-ascii?Q?y2v8pI5D6/LNTENTNJl1dJsN7W4zk8RIBYGVrgmyqZz0vYecK5Pq87mltcHZ?=
 =?us-ascii?Q?/r6C2iOAxbqXsD1qluOmmhVu02aPb+yh3PfxRRz45lcrtHXD33NkHJh9vMer?=
 =?us-ascii?Q?AL9dzmD61jZ1Tex4aC9U3MGLNT/YOIRTjq8BSeCO7gGR4xYD+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YOSnNvLTb4e7wGuQKmEVqQ/eVQN4czVXJIOJauFmaGzilOfepZlRcIHqab/q?=
 =?us-ascii?Q?IMBGsVkk8Yal3nQKD83NhmXcax4SK3zsCOzx60ONE66RgUFIPby55SXtX0k7?=
 =?us-ascii?Q?GbfW6uVC+71WsPYLTOszeY+3D/86TGrRlI/f0a4oTfUY3j4oQrE9QqXI9fFq?=
 =?us-ascii?Q?16qgNhFbts4B1Wy08BLdm2OEO/wmtIjfoLQXGp8uE95TByrMpstIKi9hQJU2?=
 =?us-ascii?Q?zs3MNx94CX6SzdpvggUecJ9bi7rsrNCNIAb4MIkBXJ2XORQ7N8tm877M09K5?=
 =?us-ascii?Q?gYfwSwQj/+PP13hhJqdHc0CDeVtAlbR3qmkpGTqqHm06Fiv4ANeTkhI7+j6R?=
 =?us-ascii?Q?+n5I4ugSyVlFV0pzMDQHffBG72fQf/XmCIzEHdOx7VWOabnNPapW0o/HyLkI?=
 =?us-ascii?Q?FDBbmZTZ0NGQ92eiqHYYsa+FmVTGrwuq73sXjAis2cXU628n4CL7aqDGPi1p?=
 =?us-ascii?Q?SS7qx0N9wylfCl/ijY8rL0S0XsINBMsu94yE5hIsK4AaefRlXM4Tt3HnC635?=
 =?us-ascii?Q?9K9ZRjabiI3tiW/Z8pawUtgPKg/9xIaKYotEIvPaK9+n3F/quJpYILpk/Rm+?=
 =?us-ascii?Q?iJSXJ+3otpSnhba0J9QyVw4GLEuoLfkGcrm6SNApI+/gW/umHnn7+Yu6V+2n?=
 =?us-ascii?Q?cDZx5Bw6QGoOfL16xl8hEoOK+rtKfd3OAxcC9GXitsspZgLPpB7AhTLdlqJc?=
 =?us-ascii?Q?wez8LtkEWTSFrmabWqUFNCoN6EriJZPpoKrXXoV6l47boCpWjM2OdGOBUyZc?=
 =?us-ascii?Q?76z5ABTMzJeb7zuBvEWydQphkoyt7c1vtPV8LwSl/emSJf50WbPKSTJFEd4B?=
 =?us-ascii?Q?8NFPu3hT/hdSqtoZsrJ/b8WdsLyA9kQq4uW5Sf9GTjw3FJAczT5uPrGn6C6h?=
 =?us-ascii?Q?ImpHT8i+6DrTuXuR4lTZJ8mAI7HstbQJVX3viEJy+dz7F2G4V+XB+lHvHFXc?=
 =?us-ascii?Q?60EiVilXya2Y6jylDhYfQptF+TEM37TxfeNq8PL7nP/GVx0ha+Qlox7nUpyM?=
 =?us-ascii?Q?bY6q6Ho2PYf55mB8nwBPPHvp8oq+NyZYzlEOr7MmOW3uAupbR8sFNGJ5VoW1?=
 =?us-ascii?Q?gDSTrh6TCNtln8fiBEsYnlvbZXnIUjdHTEAP8qAAOUzwbgMAR+QFMn/05Zbe?=
 =?us-ascii?Q?jqSypvIInKVPwxNal6amfgmp3uVzIY0k/mMey60znv0ZbAMYEK8JICnw71Lh?=
 =?us-ascii?Q?78gXxQ+bCDOlzwYyzpH0xVwgpujOWFkaBlQTEcPM0g3TRqs3LRFI+pgbSLnp?=
 =?us-ascii?Q?gksw4pK+T/ETML9tLG9r8Tj7zyCsa4GK4i0tX8wPAaXR2ixgC93DLIwUU/CH?=
 =?us-ascii?Q?CTm+EzZYPiNaUns9QBfY4Mm/L9eEJxatr70k9jtKDhzXmEwtRzzw0ODKe/K9?=
 =?us-ascii?Q?iJtEQxGzUWg/wQyZ4N9acbmt1RqqS3harfybyEPnj16MkbvPo+L+dh3GCnmZ?=
 =?us-ascii?Q?o7rTBbyyT+p2WuOO/B/3dINgU4E4GaUn9lG93fpqrk2jF0psmh2WkOKe4Nx/?=
 =?us-ascii?Q?kxcONiR49qFAfv1P4s/WEtCEbMw2psoOJtQ44TgT++C0sKvt5oBHhXXUAioS?=
 =?us-ascii?Q?3CtZxg06lYGs4uiHvml1DKJrKF1XSWiT4wgGGcOA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cbbbf4-4146-4431-0f99-08dcd2afc308
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 22:19:11.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 873EZCDdpSOb/07dfGIz95CWf87azWc04YPQuw7kDw4ZRvu3THCDxs1IKughn8tZv6kLChz3+FqmpC1Hn40W8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8180

On Wed, Sep 11, 2024 at 11:14:15PM +0200, Marek Vasut wrote:
> On 9/11/24 11:10 PM, Frank Li wrote:
> > On Wed, Sep 11, 2024 at 10:28:52PM +0200, Marek Vasut wrote:
> > > On 9/10/24 9:07 PM, Frank Li wrote:
> > > > The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
> > > > increase maxItems for clock and clock-names.
> > >
> > > This mentions MIPI subsystem, but the IP in question here is PWM.
> >
> > Here, mipi just name of subsystem, not related MIPI IP at all.
> >
> > There are many IP in i.MX8QXP mipi subsystem, such as i2c, PWM, MIPI PHY,
> > MIPI controller, PLL, clock-gate, ...
> >
> > >
> > > Are you sure the clock are assigned to the correct IP ?
> > >
> > > Shouldn't the clock be assigned to some MIPI IP instead ?
> > >
> >
> > Are both question still validate if treat 'mipi' just name of subsystem.
> >
> > > Could you please clarify this in the commit message ?
> >
> > 'mipi' just name of subsystem because the major ip is for MIPI. is word
> > 'mipi-subsystem' better?
> Let's find out.
>
> What is the 32kHz clock used for in the PWM block ?

After read document again, it is one option of input, CLKSRC in PWMCR.

Frank

