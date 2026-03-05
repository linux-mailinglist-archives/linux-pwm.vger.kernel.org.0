Return-Path: <linux-pwm+bounces-8195-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H95GeT8qWl+JAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8195-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 23:00:04 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF378218BB0
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 23:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD733011742
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCB35F8D1;
	Thu,  5 Mar 2026 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="afqk5ljm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010003.outbound.protection.outlook.com [52.101.228.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C227EFEE;
	Thu,  5 Mar 2026 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748000; cv=fail; b=twK2FlUlqjgAg3d3/q5fuqeWH9raQjvzuQlnkNZT+EiI7ek07nnT5qUDNrsOryVvqjKXrrNVHcbNkakV8gCtVInmhslmm5WTQ36ZEdG7E+OvKAE1uHFqycMBKpOmvWOkF1l4JImx3fY6qcoSWzj9AoblrbCzIJZW8wW6AeNc1jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748000; c=relaxed/simple;
	bh=F7KtqzgyKfQfoWBiP0DKUF1S/SFHw1Vpjfkc3bfAew8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbXHmZpkpTJ0gkR+yXpINrqBzIpwGR24VdzhQ604MBgommUKQYovf9tLkaa0slqPkB/wmeoge9sZ7ignPlTA+3sxa+LAkrRf4UdiPULBiFM2sPBUSK0f7vgXgZiFNWtoAyQsYiBtx67fgLZK4CAOF55Ghl23xp3HNRkAnfhAmv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=afqk5ljm; arc=fail smtp.client-ip=52.101.228.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfGfq2domxrwJ/0tnJhMgg7t8LUbs9zAuAuVh/X+n6/TnUdHaIlXYTtpJoQGlvyWImj3azBzC/xB74g3Z+/pAPaDOkjA+ZWKrFRGtdeNX28fCVKYTqcA0ZxTQytANwbT7mMbNkH0ISiPrD1VpTBMv5HFjZQgVINSbPw1DLj/0nfvwmLNPKtBc5YxCFhxfO60WITjIIBAM9AxVTEyqEgfrsJZ3fKAEj3qpSCBNaJP0j3vvoswPpkCF0xZof5a3nUcnBVfzFECsgb+esJi/6/HYAL1QCim0LZ9GM1AzKpRsYqDJub2Jz93nnCtSbzjy0yJzCeKM+5P+owQ4GzIicTFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtVgIBMJIe3RzcMShg/oJtUewo8+j29vq0NiGQRNfQU=;
 b=w4g+o26toGb0ZicneKbMlI+ecXR3It6VNU5OCBMbWKdQGOEviiyjat3Rw14rOonBNjJ0uMevO3UPAM6WNJ495VS/cD7C9igw/tuSXJmi2RjDq1u+ESknAPo7CC/5AfzfYrlToqvM+cBEGFvTHI7mPLug0/2ryobvJi8d4phQjc48mSjbeZTiJMmLM4lsQkEXtyvhXK7SxX+ZxomT52ueLr7u8gjK498tkGX+2jU/TveuagxCN4PoJ0M8ZOzRL5Z5kp2mDIrKeX9o1pt1IbFeABk3bZvYwSZSlbVDerKWSjHVvJDpt79UYezM73k5toB8Fenx4/+HviOCIcConBBIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtVgIBMJIe3RzcMShg/oJtUewo8+j29vq0NiGQRNfQU=;
 b=afqk5ljmwjMeMntqw9CdMrE0vSmGlKePZEi4lX+BwfJDDfb5gK7oGuq2/7N81orZ+w97FAoJin9+Dgig7sy05/an4NnW2s1HKmrVwjZ3XSIjkq1sB9Uw8w0E5o1H1jQ0fhIW2w8VygeLjTasPa0BRh/3PKKA7aPaItWINXgEgaU=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TY7PR01MB16219.jpnprd01.prod.outlook.com
 (2603:1096:405:2a7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 21:59:55 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 21:59:54 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
	<wbg@kernel.org>, Lee Jones <lee@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Topic: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Index: AQHckeNxm+l5nvVDhECE0kd9r0GiYLWf2EkAgADVIsA=
Date: Thu, 5 Mar 2026 21:59:54 +0000
Message-ID:
 <TYRPR01MB15619661CAEFBB9A94F8C1CD0857DA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aalEXwdvHtToZmRQ@monoceros>
In-Reply-To: <aalEXwdvHtToZmRQ@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TY7PR01MB16219:EE_
x-ms-office365-filtering-correlation-id: 8ccc76b0-ba2c-430a-5b58-08de7b0288c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 hEeTqUKOesEYrbm1yl50uBXkCRxLnNxQko+30v/R/TH8muUNuhMHSUQ3D0t5Ta7p/k1cOJ+jw0jhM5txoSBKDoiQWXm7u1gN3wOixRQEHLOD5PkFOdP1hyJ0fhlUPI+voIPSDC8PTdtYoafk0fcBScGCnvcdVYYU5fxU8k9POhBnhhsLYW4AV8nC5synuLkANWyM3X1mOeivXe3zDl+X4QGDEMDPS2MJLdelGXiGSnNN06Lj2JuJAJ8PJc16VdD2WkIhKGqOodh3q1/DOIuCGuYC4qXxCYGsNAUt9SaSCuwanWwgWjoY2K0mfw6kq/6vrY1Pb6sRpzCGMlmntBqMtT9e6g1+AtzfkC2KFutwF+bvqFO0wBGjZPN/FyIN27N9RtAEF8ARpPpGG4+ApJjxHHK5pJRSwhG9TOHFHSPe6252awJ8C306r/zkhD3LKJ8xjiDtaPs5fCZB+mBo3H5gFr/2ZNyy1ya9cNXGpfBkqFGY6vpSb4BpWzyt667FdX3q1ysFvw99QdeUVkZ0mJ14k57u1O1RoT4cOIL66HtU+jQoQelh5yCk8SbPJfSP3p8wycuAS6EmNzmpRr4/xhPuT/Mj/I2TDXuIiKcNoUzdJXJhdk1dWn6Dr/50mxkRGGdwhYWB0eQn1i/q5G6n0pC/x6AVwLYNfsj+nNEJud4tJg8zB3k321shCDl/V/iuW8zaPVtkvZXJ9WzpG46BTNTK7HBTCoI9JqQBYoF3jmGx1YCAsg8mk2CI/zNFZXUulujxDfm9zgLPUSXoOhbnQIhUwQ79JB/17bvDcG0kQ+N1tVs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sPYTwzS182JMkYFd4/x9CWEYm1Ff4XUvx5gHNCANCPm+fGiEPXD7m1s7AQ?=
 =?iso-8859-1?Q?OH0umCcNUZ+1wilCwcMR5xL+e8L3Zq8RmoUFypiQZskqDBztASg7YHOEOM?=
 =?iso-8859-1?Q?j4YyQauPb7+0DkeOJquc0LOd2hWlmOGtxGR9GD8BPdDIovKN93OAvLIrGN?=
 =?iso-8859-1?Q?2C2DihjmqpJAx3nitpl8tvA3zgrR6Gn/hPDvUtyET9RfBLV803AkgLRuyO?=
 =?iso-8859-1?Q?guHhSHx0xp0QcIcIAn8hI/FKGgtEJaHUqIN9BUi3efes89RKGQB0co+I+T?=
 =?iso-8859-1?Q?CnQbIH/MmvshKOkGHAi2ExQmILs7FmJO/MFVDJlq8m3HCwBW355Ll5VyiO?=
 =?iso-8859-1?Q?uRu+6OTanthoYGwBg8WdDLiEH3LtKyU2ZwvNyl2T67kLchI1ZgDkenggfc?=
 =?iso-8859-1?Q?67iPXz/TfNI/umDGyz/JuLNJUTDqqUkedOc+wPQ6oJptUC0jAdVAfbsoEw?=
 =?iso-8859-1?Q?zZYNA0j5PO5w6gxeOSvut5L7rxxVn/ypbRy1s3yt0MdnjqdIjcC1gV3/1K?=
 =?iso-8859-1?Q?IAxSSWxOkHdwUeJF5BlVvn73J3kXINETyOeA9fnO5xAdf8WMrwiDmYwPqh?=
 =?iso-8859-1?Q?lPi6aR9wXsHAz3ZWBJjnL1p1QC6m+hR0HJZLvAWA6l0gzuM0hFUqLdCrim?=
 =?iso-8859-1?Q?Z0FLIY4ramJwpAOgEfjGL13GSViaodtD/nBCbQQ6fkOWcC7Xrg3mX3VoAY?=
 =?iso-8859-1?Q?OUhsJq+qpx+uaiAFSUbrBG6/oZqzZClmX1fGcH+K/DqVO3wi/re2pRYlPW?=
 =?iso-8859-1?Q?5j/1scXuKJ5gezZHXEBT1gfly2dRNpSyGMTbBLK74Yw6uTjse3nv6QAUa1?=
 =?iso-8859-1?Q?XnFFYXr3+MlMdBrDIDN6i/tJ7aYWkbW1YzuasQ6D9ZXyIA7ydK3Ur8xSIW?=
 =?iso-8859-1?Q?tIimbY36qg5qmX5a15zelwqFBLDEr1lVE21UuBjLs/SmTVY9CV7KSmaKo9?=
 =?iso-8859-1?Q?ciT+UVcv/9tAjrPvS12QxtIghKaGfTXykFHIMbVE3cPnJF4J67zL29WV4j?=
 =?iso-8859-1?Q?T3ALcp1ro7NQU5XSzBqoy5y+Ll/wk9rkIEmwMOxQvMdJ/mzKW+XZh+HJIR?=
 =?iso-8859-1?Q?0TS3Z5ryfohrEGnaofwpc4/QQiowRd8HNARPdwUaqYocqSJ8/EX9AdtX3S?=
 =?iso-8859-1?Q?bHcEILsZHyQE5CpUm0i1GLiYR+SYe4mkU9UPwk69QoJ7pl/5JZ4wcwD//0?=
 =?iso-8859-1?Q?ChxwvfJLTjsRefVmXVwc6UkY2ksQ9T9CgSutyVe43m3NAzvvXIq4FPdzLR?=
 =?iso-8859-1?Q?dAGvBbWZeFVY1bn8VIiQDXqdyJIpRLiFvfEHGAhoa8b9Jn1mhBf++M+LDe?=
 =?iso-8859-1?Q?/Ty3//TlvzHE/irawGiuf5xl0muEmwNUc4yJSHyNDaTBLLFCaqxAQl6K+v?=
 =?iso-8859-1?Q?TT/QPGLhdvLTy/bdlZJl+62AtUvCAyjsZWq5r5wQ3L5Gva4I+drYAbIroi?=
 =?iso-8859-1?Q?ZRQ0kbRnxRj4v/zPOiSphZD6fc5mmSVFVnSY6+QGYRefE9m3xNpL9hg1JB?=
 =?iso-8859-1?Q?X2AVVqp8YFKKmOKeozGDUctyG+1jYn7osGt9froD+Vhtx5qfBq/5kSKq/t?=
 =?iso-8859-1?Q?NJNODAOOt+UrgCcio3QicYNu0dJUgoOr7hcqwDyJXB8qnL8oqt2FYiY5MG?=
 =?iso-8859-1?Q?Ss3w5XwDEWuTLMdHTQGQrWPHygG6JiwNJWuOHQxjZtQUwPD4ssfKVafHSI?=
 =?iso-8859-1?Q?CANKFoMyO26t/oFDVWOgBxH2iCvxI3abC9/Dd2s9T4LDnd99KEV5s9+5Ym?=
 =?iso-8859-1?Q?9UbOj9+MdKaGRdBU1cV5r+UO0fsrxWrZJkW0xT4EdEGiiuLYk1IuYFxYEy?=
 =?iso-8859-1?Q?Q4TBDO/pIoZSp5WzWH9qrm/1WGWZQe1BgUmnKPW3CAgcfhRNAfj3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccc76b0-ba2c-430a-5b58-08de7b0288c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 21:59:54.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huXiOUbjljrcBieBdiVEGHvgOBLgLbhu3M8g+FTiePJNPTSFM/WUM9IRE2RsrIAz1gR2c+XAhzdiXf2Vdcb3iD9TEh62TgXAZa1/UA4Sx5k6XZrDBbKJ8fp7sS3xW8gt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16219
X-Rspamd-Queue-Id: EF378218BB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8195-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[renesas.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: Thursday, March 5, 2026 10:57 AM
>=20
> Hello Cosmin,
>=20
> On Fri, Jan 30, 2026 at 02:23:49PM +0200, Cosmin Tanislav wrote:
> > enable_count is only incremented after rz_mtu3_pwm_config() is called
> > for the current PWM channel, causing prescale to not be checked if one
> > PWM channel is enabled and we're enabling the second PWM channel of the
> > same HW channel.
>=20
> I don't understand the issue. If the second PWM channel is enabled
> while the first is only requested, changing the period is fine?!
>=20
> Can you please show a sequence of events that result in bad behaviour?
>=20

Hello Uwe. The issue happens when a PWM channel is already enabled,
and we're trying to enable a second PWM channel backed by the same
HW channel, but with a different prescale. Although, because of
other HW limitations we cannot really have differing periods, but
that's handled in the following patch, 2/5.

Here's a sequence of commands that results in bad behavior.

I've added a print for the enable count and period before the
enable_count check, and prints for the actual period / duty cycle
register writes, just to show that it gets thar far.

root@rzt2h-evk:~# echo 0 > /sys/class/pwm/pwmchip0/export
root@rzt2h-evk:~# echo 1 > /sys/class/pwm/pwmchip0/export

root@rzt2h-evk:~# echo 0xffff0 > /sys/class/pwm/pwmchip0/pwm0/period
root@rzt2h-evk:~# echo 0x7fff0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
root@rzt2h-evk:~# echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
[   71.916095] pwm pwmchip0: enable_count: 0, period: ffff0, prescale: 1
[   71.924085] pwm pwmchip0: TGRA: ffff, TGRB: 7fff

root@rzt2h-evk:~# echo 0xffff00 > /sys/class/pwm/pwmchip0/pwm1/period
root@rzt2h-evk:~# echo 0x7fff00 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
root@rzt2h-evk:~# echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable
[   80.063208] pwm pwmchip0: enable_count: 1, period: ffff00, prescale: 3
[   80.071028] pwm pwmchip0: TGRC: ffff, TGRD: 7fff

As you can notice, at the time of the enable_count check for the second
PWM channel, enable_count is equal to 1, so it does not pass the > 1
condition, the prescale value is not validated, and it ends up overriding
the previous prescale, messing up the already set period and duty cycle
of the previously enabled PWM channel.

> Best regards
> Uwe

