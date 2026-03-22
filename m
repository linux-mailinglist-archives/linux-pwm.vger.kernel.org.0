Return-Path: <linux-pwm+bounces-8332-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN/XKK47wGmSFAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8332-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 19:57:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDD2EA64C
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 19:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E483005751
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73486371D12;
	Sun, 22 Mar 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nRUDA9IS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3337648D;
	Sun, 22 Mar 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205844; cv=fail; b=OpGclFHEcjICFb5US96Gnb5uHKgKO6S7tUOfuv8vaDTXc75v7yG2jL4ASyeRkRQQo9fqRlPkBiIkak+RobAWedp6sPXwc1pJ+HGsDc1RywJ2hRJiwL+vlWw8RTDHtLBblAfTDJCpJKO1VL8du3i/XlcFHW8wy1KLVfamKxQrwwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205844; c=relaxed/simple;
	bh=5E5ffIitIKdLXGDVpQoCtA4fx2ilernXbWLTqOFOjf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F446tHqTzeZ1Y7kVMaSLhIdrFb35mD27VrQzG2g9ynjMAsvsPtEw6zqQYyj1H3npLSiZgI4LWCjw3Al0rXNwFZmi0294J/vZj8Xuieviak2GkTQWxPM4QGSPyp1y3WUGnwhc62tvzmcJNGAH6jCumv+ynTApvplan9XxWgNbC0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nRUDA9IS; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtGDHCWn90NVu5d6oMP+MKPErS0uzLRIy+mjUDYRIl+LYFd1Sx8gjJW7edxKRdfvjLdd0n2Yfj5iKgufQmXtR/gGkmTXIMJVZ8WXiPRoycuAoOxs9eG8hvho+EhkQrYg9Y4YoxFRWwGzF63g5HHOU0Et66hyKHA0n74YiNh6jwg2HpJ6viVlN+Rss96+q0lfm69SqYcmEO7Lm6onScTRTKsUqlG8cV5FWILvYcUelXjxbz85aY/bANSa6EwdjhLrZDflTyGNz+xlmMTC6czbp30PB/+uAiiZphJWlC2fsmFLgA9t3oTW63abPTv4w8T3LPYqzlSxHQUKILaqtkiFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E5ffIitIKdLXGDVpQoCtA4fx2ilernXbWLTqOFOjf8=;
 b=DvZjcXzF9Fvi+1J5Fuq8DsUGVnVYFMFdewa4M9Og7CkfVlHbKXuoAwnclP4gzC3DG4CdSbwf8CKFtZ3qkbK85SGvXArj3OdvDVB3GR8Sk9LS8ss8nt2z7VSDrWGvTwVmx5yrS6X5ALYZtH31ZG/evaDjbSjrhZEPC6OvV8CDnTUFBeHmcwwSAlLL8aCfzpTHUPHbANINElaCS2Uj/ccZBa8pxbA0UN7LW9CwICoxFJ1IUvMQtT9aylvniF7hxmq5VDAdVik/Lwdj8MUwnrLm8ryo8cZE6vwIHBqlv8egIKfDQRSnrmQQEON+0IRykbmLecO4x4hFX5GAcWhnWdmfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E5ffIitIKdLXGDVpQoCtA4fx2ilernXbWLTqOFOjf8=;
 b=nRUDA9ISJ5kVffsgjw2g7K0f32qAO39nOyU3LeqHS1FN/ZXpRnTitVk3cfUTr3zKM002rn3a5PoIgNPIM2YZlDR1juL9CFMaVxFSRpx7+5DEMo0ZE0jb59GY+oiSCZcCt/5pBIFgGzXI6eK67DEWXs/mo77uosW7RNWvivKzYM8=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYWPR01MB10997.jpnprd01.prod.outlook.com
 (2603:1096:400:395::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 18:57:01 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9723.030; Sun, 22 Mar 2026
 18:57:02 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: William Breathitt Gray <wbg@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>, Lee Jones <lee@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 5/5] counter: rz-mtu3-cnt: do not use struct
 rz_mtu3_channel's dev member
Thread-Topic: [PATCH 5/5] counter: rz-mtu3-cnt: do not use struct
 rz_mtu3_channel's dev member
Thread-Index: AQHckeN+zOWlZRxvjEyvqD48rWtiM7W6braAgADGS+A=
Date: Sun, 22 Mar 2026 18:57:02 +0000
Message-ID:
 <TYRPR01MB15619A8E68E7CDDBB0B66C8DE854AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260130122353.2263273-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260322065813.264398-1-wbg@kernel.org>
In-Reply-To: <20260322065813.264398-1-wbg@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYWPR01MB10997:EE_
x-ms-office365-filtering-correlation-id: 49b54688-b9e7-4471-efbb-08de8844cd95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ik1zTsyrrt0pQaNBK6FKZWPd9X5Nt27FvOqRFSieQSlkXZrQPRAQttlG2DwVagZoIetE4x4y/rShTbZKSupZA5Adc9BgYGD4tdcNwf+zDo4FgRWARKnRhxxatxML9z768EKQRl7Hp9UyS4nbfkj/3PX3nkHpzW1z2Fr999SQ/cGStlVfslbhFf+DPFY8xaAVVcGM+qOnI3UBXAcBDPnH4ISh0nij8pOa9LBXfHN+XYNveH9mdgPb6obSenLCozJodYjAG/pO4Sd6r8vzW723tof4DmNDOqOwXcMqiH1NQkrOoJNJyMfkWrfstjiNRUKiV85ZNL9KB4ByA4YkGmIAYkRZFzTpZ79q1GVbRXI0m8LxZA38zaxsdDB7xLeJftJm6xy3GqF5/bpGRLrqTlWlSx97uVSCuz2GXXz88ao5YszH0duRA/cv8uQ2fWv1kZGDdY4uqPl239SJX6URXvpBkiz19Xwd95dSYAP2RodOCnX8VBpdKbwL1ZoPTnbIN9i8ASCtL4rLchEt8CiVv0nluXylIzer90ASLQSFpo0z5CkraDiD2nxvPOXOLdiTaMYPvplYYw2wH7Q5ezG77k8662tVajr1k1VtbWQ995CuFVJFhhuvSsk512O+x3znF9MOqd2CwkbONtdrHtde00lp0vByN0MkgwBMXOiK2Bj9zPn2mcX3pZhT1pT5IWrx97Dv0YnCbjRjA24AfI4kURfv62nMaCrzvDUCSTMrh4UIShAvby5z2miyq2uUonLiEMQ9O37OfzIYPgrYrWIoggksr9pDypkxakOcUK7TAvoa5Wk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XIVMMAoFozAxaS3n5sPQ0yW3yezlNC411HqRHdNrsjpmt5Alg4wS1PeFck?=
 =?iso-8859-1?Q?9y3880elmhgG9RrrxSD1EAfbKN+xCLojMzfRwwG8cfJmF8DAaszMyBLvcd?=
 =?iso-8859-1?Q?yEAuchG5G9emYPr819R2bdGgAKsOZdCQ95N+4X5UIhXxlypO0+ehtkib0I?=
 =?iso-8859-1?Q?T1+T7YKRqPNcQc2J913Wj5sIFjojSiktD4p6eGYtz1KPNH0SyQhWYdt7C5?=
 =?iso-8859-1?Q?AFv5TZI1LmBohL5XzuxyjU6xLSXkmUdJvRSp9Yv32eV+UaUhSEetqI87TH?=
 =?iso-8859-1?Q?wcyAzYhJCdc8/Vw/3Fw+ZN1LY6F7sIbGdGwbAobkc9f1tG//okP4WtKR9Y?=
 =?iso-8859-1?Q?4S8IRpZCa7dmEzSpPIjdk2V/edudTzDziLugqAuEIFxQNRftrMA8ZUvIBk?=
 =?iso-8859-1?Q?tUZlb49LXYKKtOut+Ag3igl2myydlHml9frGMYQSuGnZgq2HWwIg3a9omB?=
 =?iso-8859-1?Q?3lBUKaaklUxyLMC0C2QOC8lVsl+GcBknDAntuBqGg5uAOBj3VDEaazRv43?=
 =?iso-8859-1?Q?FG+rINkEhVDPU31Ag4kscld0SHj4DCSMfj2v5Evn5s2o/hVAxdQkhSzscz?=
 =?iso-8859-1?Q?MGcX058Hw6Ukz6sJ/hgyQqYLIYuHR4He4kEAiTsTeO2vCLBin0ql3PMQk5?=
 =?iso-8859-1?Q?9QPAQOX7LQZcqO+cpgGawTImEFZawE8uoQCOfHqy0GBjp/paJPrABJOVAw?=
 =?iso-8859-1?Q?QYRqgQ6R/8ZFnBHZj/r0sfxG8EdaU2WXDG8ocESmmnJkeio2/r5iGqsQHP?=
 =?iso-8859-1?Q?zxx+hbhEtC9VH5kCQoX104jH6bWFFvQRcdb//s/WwWLwD/v7wyDyLLwf7E?=
 =?iso-8859-1?Q?TEZPxr65U2XHplX9mWUeJ2T/q5kME2nNtNvQ6M2y8lkIoNP1/5wpDCuybx?=
 =?iso-8859-1?Q?CvX6oMijF499kyQpRB1AoL0WSZLSW1861TtZGZvpcMJp86/BF10BhRlMYS?=
 =?iso-8859-1?Q?kXcqwksDoA1dmwm3wCdqKQUSWt4USItd30TsbRw+hqz8LyA2YzrYpjGZqa?=
 =?iso-8859-1?Q?ZZwWBUhDtLhNQsVjqI69yeXqjVUXx6rw1zRvH8C1RuTwt1EN4JJSL39702?=
 =?iso-8859-1?Q?1I+2aYJon/TLs/Z8gcCWkV2pOuCJgqyeylk63OE8M5lXwdUViAsWZeIZSJ?=
 =?iso-8859-1?Q?9DwSGMOA6OIH4SvCh7h8kCW/jY1BF1VyECbqza+efm8Sa0s1LSr/eCom3f?=
 =?iso-8859-1?Q?xUXTod6MGNB+TG5nEap12HPtfV7dOXVA91ZbxxBaXTpU0Z7TIoPMaqpHXd?=
 =?iso-8859-1?Q?lgegLfnuUF/h2PdO3Lci6f8XRmpjP5O2RmHSLf3mC+qN1SEI23O1f1vFbi?=
 =?iso-8859-1?Q?d8alvGhj0jQOJ0R+tqoO33TR4gzfmZH/dmHZOd1wsQBVEQ/PRlBkIhqa5U?=
 =?iso-8859-1?Q?xNowxxQE727BrtEa3cyiBGAnlBcUJ1fkFfAD8Pvg4Nx2BaI05zacyhIKan?=
 =?iso-8859-1?Q?jC5TlqYEd0GXdk/gUcp/FHXcMF04sAAIQbGZpvtuTVSWLo7SaWpOQlVWJi?=
 =?iso-8859-1?Q?aD44q8sHQj+uss6fP34xt32f4bM5WtRoFT+sP8/EUaAPXiyRnALJJ1kd6t?=
 =?iso-8859-1?Q?1Zfhma6GJf2+CDtX+z/5l9rve0NlC0yRpx3abZvy4rlBs+HEMqY1vZkAKx?=
 =?iso-8859-1?Q?QATo9v6O/z5444w38diiaIZaAgxLHr8KKG1CBNwza6RSyBEK9OJEjKBUKL?=
 =?iso-8859-1?Q?H8zs0wEiZNtRkxoyeKapmemZzpO9gOMlXjetas5aJ2Zl9oJn8uMPrq8ent?=
 =?iso-8859-1?Q?fFH23lVmR6Hu9rYW77VfO3JFEb+tMpAaEG8soqF6Wwp6PyB9/ZQM217hfm?=
 =?iso-8859-1?Q?i5mo9Toqk6ZkKmnhzOzH3DPW9KQPRXvY0cT8nF2eev9mPxAofMa2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b54688-b9e7-4471-efbb-08de8844cd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 18:57:02.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZsqU8CeSMidCvbuPn7IHMFY8xdYShS13QvR1xLpykuYYxmdFjF5KVK6rJyJe2QtL2HeoJ5ImUWJCmNx1aP/1kDmUbTC+veu7Ki9YfrtWgcMQr8mkW5HH6oPQCVDJR3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10997
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8332-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[renesas.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:dkim,TYRPR01MB15619.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 12FDD2EA64C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: William Breathitt Gray <wbg@kernel.org>
> Sent: Sunday, March 22, 2026 8:58 AM
>=20
> On Fri, Jan 30, 2026 at 02:23:53PM +0200, Cosmin Tanislav wrote:
> > The counter driver can use HW channels 1 and 2, while the PWM driver ca=
n
> > use HW channels 0, 1, 2, 3, 4, 6, 7.
> >
> > The dev member is assigned both by the counter driver and the PWM drive=
r
> > for channels 1 and 2, to their own struct device instance, overwriting
> > the previous value.
> >
> > The sub-drivers race to assign their own struct device pointer to the
> > same struct rz_mtu3_channel's dev member.
> >
> > The dev member of struct rz_mtu3_channel is used by the counter
> > sub-driver for runtime PM.
> >
> > Depending on the probe order of the counter and PWM sub-drivers, the
> > dev member may point to the wrong struct device instance, causing the
> > counter sub-driver to do runtime PM actions on the wrong device.
> >
> > To fix this, use the parent pointer of the counter, which is assigned
> > during probe to the correct struct device, not the struct device pointe=
r
> > inside the shared struct rz_mtu3_channel.
>=20
> It looks like you replace every instance of ch->dev in the file,
> except in rz_mtu3_cnt_probe where it is initially set as ch->dev =3D dev.
> Is that line in rz_mtu3_cnt_probe still needed, or can it now be removed
> too?

The MTU3 MFD driver still depends on struct rz_mtu3_channel::dev being
initialized for retrieving private data from the channels.

I have patches prepared to remove that dependency and removing the dev memb=
er
will come afterwards.

Thank you for applying the patches!


