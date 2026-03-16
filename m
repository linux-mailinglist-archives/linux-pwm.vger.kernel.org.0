Return-Path: <linux-pwm+bounces-8270-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB8cF5gEuGlpYAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8270-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:24:40 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817029A4BD
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B5FC301D4AF
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689739769A;
	Mon, 16 Mar 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eyzm49nW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB4361663;
	Mon, 16 Mar 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667365; cv=fail; b=fde3VjLYiL2a5VJc1lc/iagcK47hGlf+P+Il5ZsA7G9Suklkle1UT8DjLRJIuKpOQXdjnwxYgh+smGzXhuwywkjbCqkEqHurreSNjyfFfoNB0l9baRzucCEZG51po+lEymPA0gpAR0SvgMszPMl6HAUxEBMbvNN8s6jS8PxZwMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667365; c=relaxed/simple;
	bh=xjHI427z2krI+gLpXd/4gmvE1s4hEOyw4Q6zl1Z04jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hhjR6VieNDXVO8mSjNZ0ytppozzXUa11Q1tQUUr/cbpbLdxgPmjfPZlo4zjQK27gnHON3xvlq29IhaK+k5IUSDdMxkPd3tx8MQKvs8LeLT3/4E1xoIVKMUjSzDD2Unw1vTuY9LU6bu0tnHuVWrz/Ov2eFBw7RmYtzdNmyDkB2U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eyzm49nW; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9rlII2123203;
	Mon, 16 Mar 2026 09:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xjHI4
	27z2krI+gLpXd/4gmvE1s4hEOyw4Q6zl1Z04jw=; b=eyzm49nW6wiiKwE9KocoD
	USISRJohu9BEIw6GsKqre1/g6sg9S1nVd9jRc8Rw4BkxkYmTNnChkfZhOMTvbpZM
	gzdqqD010RFCGZ8spNWXVqcJX852mRUstvvHAs24owA7erdBlxQvkR0FeGs2TzNN
	QgD6KS44nV+tRm+x0MwzwfGMzjGYELl8m0uUTQrCLRaS6GB8GV7pLr3nShtbZnFk
	nrS/m5ZduQUXthaC06xxQ719vteOD+2k1QBSIQx0cTxtx1oYrPYmxdIFrzOGpMrF
	goTQhEzgD28Z6cPBAM+jzd1aX8g/04/LCYQ+rr0JKWAWBWFTy0f3u5hwCl5GYKxE
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1h1fbhk-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:22:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBJGkXmwAqvoQ/C8E+PvtDBYBlcqoSL9ZNU+/HmM7H60i/bhrJoPang9CD3/6fWTZtepSuaK1VAOGR0ISvPK1SSQonHthVaTTMi6uA1ImWRxaiN2fzroOg+JpR7CfYVa6HNtZ6g9J8lvFvaEGPE0lkav0tiPmbyfkj3PJFPanBoUWXVIr2q//PYq8R/v+/Doo+B2b6ApHtpCnajo3Rxq7mlFn0Ie/kKNA+XpD81qmB5O0jm0VUfoWz7rh5T8Q0PKR1b6FsHB4TB7RhB3JAP7JFpJnIjPSwEbOfQGXxjiz6djdzoomXpuLDlP/0BAkUgzxvs13+bbnx2xxkEdoguyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjHI427z2krI+gLpXd/4gmvE1s4hEOyw4Q6zl1Z04jw=;
 b=PvCNaf/8TbkmzRhVOONwXQ2sPf1WSAfg/TnCHI8Q1qFfQfz6g3mpgb+H5RG/A0lxuML7HsyY/TsrVpyIB0RvlCZDS1PfglIB3nm5Z0+b1zCLD+dP57C5lxejWxMr+sMZteSyFiWUJgK89nOWmO/N7JHLef0nQ/jnqjpAIXsTYK5NjwmSydChQyzhRml7zK62f8TKhqcGHFGJj3VcZO3Eb2ziTp3DADg65ETe5RofglDv9A1JUcEuhD6w9F9Xs1buNygnPTadlZLQ47mfDv01/CjliHZ0bnnieMi8DY6Pn/vBl5bbzmRdV7+dmpJmX9tuqcUY87j3rSrHGbz6HgjtPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by LV4PR03MB8283.namprd03.prod.outlook.com (2603:10b6:408:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 13:22:06 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 13:22:17 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHcstE9lpW0ZwF28UejM3whwuuFz7WuXaCAgALHEUA=
Date: Mon, 16 Mar 2026 13:22:17 +0000
Message-ID:
 <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
 <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
In-Reply-To: <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|LV4PR03MB8283:EE_
x-ms-office365-filtering-correlation-id: 7423b09c-bbc1-40f1-b877-08de835f0beb
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 I5SwcxxFY+CSPEKFNGqi8w3rIIZJsek+cZXbS+yvad7EBs8Rk1JWzBsQ544Cy46Qd8rXt80UaoqFXuG/Kmelq8QNR3p3n9ebVZB+GvnY8w8ckrtUPmwONc4sc6K88SrSTTD7hJAjst93FKWWh3BfYKmbgVKLIzo/cyxJfkymbjPRCobqP9Iq3IvFtBxD/yJT/rV8vNmuJbglRL8Y88+PsAGnEo8LRszHDAXCEua56hegymYWSN03XyBEzK9LFItzK1YiqJgn34Nw+RV1gGbwNDse66oOX6HY8M83x3VNDmstoZ8LY+AHUxjw/x4xUjdx1Qf4V1CrdsNCnLAWK47fORL7aqgo1LvDrp9wG30WHqTEIOy1j1ioIJJMmZTvA2Qt/x5gXE/es8IR5LJFRFeQ7G181wjjnZW1QjFjPtfkXB2afnTj8vGFerLaZ9aOtooibjLjXpG1HAiHjU3Ve2jjnQ8G+jc2uaNt5JRHWfcVOUSm9zQre6FSqYffduuYPlrjrbI050vTnj5GcvoeENcZrRYBMlgaF4hEUboMrFTBNvux8rJJNZzo6pweNs+psOYm34sy8P6pYGS6Va+BFdOjxyKLS3YPTxTXKbsoC/XnrFp1Lmdzd+9Y4fsqTtQkbJ/+KI3Uuwwl2DzfGtVcR9zFcz6VrOeqSJ7U4EKRdynKUW+R2WPu+eS68ACbgC4PsPNgYrtplLiqPEtYmbosGnYfgbFBDEvBjgEvTRlkCaqt6Bty4hrr0k3qLuEEBGMtTeWBl6SnvPD1v01NjHh7oNUYV7RVUHzsGYjZ8sK22VtDgECGd6m3MVy6sx2xZFe3f7hF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzFFaGxNOEtCeWJvZjJSbGc5Y2xSWU5rbHNvd1dxeWlEWEVaNS9IUk56T0s0?=
 =?utf-8?B?bS9tZlVZYVNiRG1OenRqbjR6TnUwY2JzbnlteU9zM2pzNHBJc1pBdmxic3Jr?=
 =?utf-8?B?Zk9ob1UyZktZZnhmRnBLYjU3dGRtZGZkWkwwaWhIeFA3L2NaSEZzNWkvNXMv?=
 =?utf-8?B?Z0pxbjNNTitPejJxRC8vUk1mNkJwMmZjQm45TmNwK2dXRFBqTXBpak52amY5?=
 =?utf-8?B?UVA3b1lYUjV2ajNFajJZQzZOV2hVN0JBT3FZc2lia3Njb3h1V1FCWHprZ2I2?=
 =?utf-8?B?eXM0ZlhRSTJENHJlaTBNREtmcHhyMUo3QnBHaWpGZjlKVysvOStCR1VOaXVh?=
 =?utf-8?B?dUg0L0l3NG4vTXJLWTE5aWlReURnSkpUZUc4dUdic2xwQStQZlBDcU9aaTdN?=
 =?utf-8?B?NjE5UnpVM1JVbytKWE1nK20vNjg5V24xU1Q0cXlHMkpCR2dLZ0NBYTZUSHNN?=
 =?utf-8?B?TDZ4Vllsc0R3MEtBTTNQazZPWnRxalZLUlB0WGRJZjFLR2xidlZ1d041bDZH?=
 =?utf-8?B?eVFmYjh3TTRnRTl5dzNENXMrQ3lFTVJzYXo5akM1M2x6VzBZVzkvT3hvME5r?=
 =?utf-8?B?RCtKSkFHQWxlNzVnYUlaRGYrKzZZc2tTSkRXeDM1SjlnZ0xRYmpxU1lBK3Rl?=
 =?utf-8?B?d0JaYnRFdW9MT0xqZW83aWVNODJvRzV5K29ZTmFUdkZzaWxLckFIQ3d0ekFo?=
 =?utf-8?B?NlI1OFZ4ODE0MWVhbWdjQXV2ZndIcTdKV2ltTVBoa2sxMTU2andmRDB2QTE4?=
 =?utf-8?B?TE9qRWJXM0xOblpzTHNtOGVJT042WDcvQ0tpeDA4QU5aSmpuVFl6V0Fwbk1N?=
 =?utf-8?B?KzJoT056V2JyL29hTkZyS1lyV3Z5aDl4YWNnZzlUb1lSTkY2cXhlbWJLWEhT?=
 =?utf-8?B?U3gxWFUyRDJKdXdqRW83VWtLbFhleHh4SUpVYXFhR2wrMlBKY0xnY0hCWDV6?=
 =?utf-8?B?UzhUTlNJak1SYWdWa21mY0RiOVVJQW1OQTJtRjhOVlpXOEN6Y2YvREdubTVp?=
 =?utf-8?B?cytWWkhDTXl3enU4cHUyL1NXdit1ZzAzeVJMbWgwazQzcmYyNlBuTUZXYWNk?=
 =?utf-8?B?VDc4TCsrRGxtM1lEQ0ZyYk1zd0drbE9kaW4xaVRnbUdCcEt3aS92ZzVYZEtm?=
 =?utf-8?B?NHRDdHZCc1p4dGhGeG5heVBoYlF0UHRuaDJXR3Z0SC91NzBGUmZSNlVUNlVZ?=
 =?utf-8?B?MmNna002RDFYRENNUjY4TDFzWXhnY2V1MHFJdVBIZ0k5YW5seERLUEZxQlo1?=
 =?utf-8?B?L1Z6cnp0bkd1SGpoaU9zMzcwcFJUamF0UmNzSDRIbzFnUEkxdVRpOVZCYlUz?=
 =?utf-8?B?ajlURmkzOFRwS0VnSER3L2o3bW5GUEd2clNkNkdaNDVOU2NEc1Uwd1lHcWE0?=
 =?utf-8?B?RlBNdFdDeENvRlgvdXFiWW1ITWxWaDBNbGVkYm5DaDhESVNlRW9EWStHRElk?=
 =?utf-8?B?cTRkV29tOElWRWFhbVM3RkJ3Y3MraGNsWGtmYmUxZEdiTU1aRlJOSXlmZWZ3?=
 =?utf-8?B?K1RtNHI5SkdSN1lTNVN6b05YYkdWdms0MGZlQVBOUk9yM0hjRDJOUjZBWUZw?=
 =?utf-8?B?NEw4a2d5Q0FqbGxOa0FCV0NMSmZ4M1VSNTdzS1NxK0JnWHN0QUVUdngzcHZl?=
 =?utf-8?B?S1ptTjIwb0p6R2lzbTJGQUY2TlNhN3oyRDRlTEMvSE5EckVkUStmNkR4T1Zy?=
 =?utf-8?B?QmwxM2pnUThONzBabCsvNUQ3dlVlNVhKNHY1UDd1RnpBTUthV3lQZGJ4QmVu?=
 =?utf-8?B?cHE5MHJTS0dqR1IydHdpT3RwUnk2UXZxV096ekJ5ckRzUVhHZy9sRnJPZm9u?=
 =?utf-8?B?NEpVMi9SaXFLdW5HUTN1RDg4UDA3VFo4NGgraEF2MjByVlBuTmhDTmkvdFVn?=
 =?utf-8?B?OFZGKzkyTENWQnc5RTF6LzBrWUZUUzRyMytXYWc0OWx4bjQwdFNGQlZwSk1P?=
 =?utf-8?B?VS81TXJxWko5TXpZbGtMLytCNzRsZUxBbFpsWUJMWjRKQWozUmVDeERUMzRZ?=
 =?utf-8?B?c2d0eTlBN0VqTG1TMWJWZERaODR6Q3RnS3Zlc1pWSEpkSVNuUDk5SXIwWlRP?=
 =?utf-8?B?Mk11UWdhem5TTHAweittV3FWSHBJak5Wb0daMXdhMzBXVDVjZEcrVUtiRkRq?=
 =?utf-8?B?emRHalVtZEI2MnZRNUd2cFk2aE5MZEpKblJOZ2E3ZHRFQzJRQlBaV0NDaFp6?=
 =?utf-8?B?QVpxTmtXdGhVQ013aml0ZFBjQ3NqMHlrT2dzZURHTGF1bmJneWE0ZlB2eE5u?=
 =?utf-8?B?N3hIQXM4RDJ5K3I5cjh6TDUyZkVtM1pmbzVNNThUMkFvMWNRaXBDQVVBWloz?=
 =?utf-8?B?MU5xLzkzbHphOUtxL1l3QThXamYwNjZOak9yakRFemJXeEovd2RWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	seIsw95RGmkk6EjRtLCzeNNjy191xZ4BoK2s7y/LDtBDYW0uJ3wA+Yo74B/cVKddXMk+JH8nQ86q9OAAg8ZI9Cf5t6j320+XRKPigzqj0qMaDg5kavu1cLCEt6uqTubzNbaqgCI1nhklOO0AyspfLQTKPc7T/zhlXncks7MRylqS6eSqI/H4Tnb+yEVOF3ss+PZOpdqV9WU/5l0yFJIBxaNGdeYpXLH0sup8wNKgB0Pn4gH5P/CEORNssG6AeXfGOFFkJMKtPEEUSY/fposLc6myKTpAKtGInb8F0TlP42CBQlgCvNSHGHeFmjX3R4apoI6HVYJ2IDQI/PmKX03VWw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7423b09c-bbc1-40f1-b877-08de835f0beb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 13:22:17.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1In22y3DFZgibNKSqULF4s7qdPzYkN+iv2b6fiAFOSfQy68CpfV9ukkr2QSUAsV4gyCiaqIJiI8/+bD1NDVNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8283
X-Proofpoint-ORIG-GUID: fn2G5piSDwySAEGGHxOqJV4yGJlwcurI
X-Authority-Analysis: v=2.4 cv=FP8WBuos c=1 sm=1 tr=0 ts=69b8040d cx=c_pps
 a=7ih4RDJ3RAUgM2BElznDog==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=YRAPYW4LoAN_lXw29SIA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: fn2G5piSDwySAEGGHxOqJV4yGJlwcurI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMiBTYWx0ZWRfX2CVuVDiXh0bE
 My5xYtHoV1RrLpIqRLUCmUoHS6H9tmcV7ZupIwY58sJ81F/Vm4B5Wu2txfyH2bYKCk7rLGrUWuy
 O7GfkoIz/H9hW3/2hr1NuQ7fnG9KNQcieq7g/d40IRKeptdLeodlkd1BUJLg6rf3EKIGPJJTz92
 BC7G7q2UPKJA6zQ9GieoiqqemNN5+4ce5fvcrtJDiPh8yAmLXl12FayIEUSW17LDgrnQnAzuK5e
 DH+Bs4h2QhGNflV6z9/0QMBjCU/GV0TDgBM4CZW2AJ7QG5zP/BngWJf3z+yD1ia4i7vFfc0wlqC
 5pFLtf1gPwOwxESVZyvm9mVmQAalG07CvpFLSYREd5BAn3x00qNmlO79eqbrhou/pDwsVoxHcyo
 ireTdo+Tea2/jgGIv69Tzu8vKp6guDJczVvmPu4uLjhGnPf7GgHN+V5Cq0NeTRrl4P8V+iK262V
 5y2OotZlEtq3Qdjbh2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160102
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8270-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6817029A4BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTQsIDIwMjYg
ODozOCBQTQ0KDQouLi4NCg0KPiA+IEJvdGggb3BlcmF0aW5nIG1vZGVzIHNoYXJlIGEgc2luZ2xl
IElJTyB0cmlnZ2VyIGFuZCB0cmlnZ2VyIGhhbmRsZXIuDQo+ID4gVGhlIGhhbmRsZXIgYnVpbGRz
IGEgY29tcGxldGUgc2NhbiDigJQgb25lIHUzMiBzbG90IHBlciBjaGFubmVsIGF0IGl0cw0KPiA+
IHNjYW5faW5kZXggcG9zaXRpb24sIGZvbGxvd2VkIGJ5IGEgdGltZXN0YW1wIOKAlCBhbmQgcHVz
aGVzIGl0IHRvIHRoZQ0KPiA+IElJTyBidWZmZXIgaW4gYSBzaW5nbGUgaWlvX3B1c2hfdG9fYnVm
ZmVyc193aXRoX3RzKCkgY2FsbC4NCj4gDQo+IEl0IHdvdWxkIHJlYWxseSBoZWxwIGhlcmUgdG8g
c2VlIHNvbWUgdGltaW5nIGRpYWdyYW1zIHRvIGtub3cgaWYgd2UNCj4gYXJlIGltcGxlbWVudGlu
ZyB0aGlzIHJpZ2h0Lg0KPiANCj4gRm9yIGV4YW1wbGUsIGl0IGlzbid0IGNsZWFyIHRoYXQgaW4g
Y2xvY2tlZCBtb2RlIGlmIENOViB0cmlnZ2VycyBhDQo+IHNpbmdsZSBjb252ZXJzaW9uIGluIHRo
ZSBzZXF1ZW5jZXIgKGkuZS4gSUlPX1NBTVBfRlJFUSBzaG91bGQgYmUNCj4gaW5mb19tYXNrX3Nl
cGFyYXRlKSBvciBpZiBpdCB0cmlnZ2VycyB0aGUgc2VxdWVuY2UgKGkuZS4gSUlPX1NBTVBfRlJF
UQ0KPiBzaG91bGQgYmUgaW5mb19tYXNrX3NoYXJlZF9ieV9hbGwpLg0KPiANCg0KVGhlIENOViB0
cmlnZ2VycyB0aGUgc2VxdWVuY2UgYW5kIElJT19TQU1QX0ZSRVEgaXMgaW5mb19tYXNrX3NoYXJl
ZF9ieV9hbGwuDQoNCkFzIHBlciBkYXRhc2hlZXQgcGFnZSAzMSAoQWNjdW11bGF0b3IgU2VjdGlv
biksIHdoZW4gZWFjaCBhY2N1bXVsYXRvcg0KcmVjZWl2ZXMgYSBzYW1wbGUsIHRoZSBBQ0NfQ09V
TlQgaXMgaW5jcmVhc2VkLiBJbiBjbG9ja2VkIG1vZGUgd2UNCmFyZSBzZXR0aW5nIHRoZSBBQ0Nf
Q09VTlQgbGltaXQgdG8gMSwgdGhlcmVmb3JlIGhhdmluZyBvbmUgc2FtcGxlIHBlcg0KY2hhbm5l
bCAobm8gb3ZlcnNhbXBsaW5nIGFzIGRpc2N1c3NlZCBpbiBwcmV2aW91cyB2ZXJzaW9ucykuIFNv
IGVhY2gNCnBlcmlvZCBvZiB0aGUgQ05WIFBXTSBpcyByZXNwZWN0aXZlIHRvIG9uZSBzYW1wbGUg
b2YgYSBjaGFubmVsLg0KDQo+ID4NCj4gPiBGb3IgQ05WIENsb2NrIE1vZGUgdGhlIEdQMCBwaW4g
aXMgY29uZmlndXJlZCBhcyBEQVRBX1JFQURZIG91dHB1dC4gVGhlDQo+ID4gSVJRIGhhbmRsZXIg
c3RvcHMgY29udmVyc2lvbnMgYW5kIGZpcmVzIHRoZSBJSU8gdHJpZ2dlcjsgdGhlIHRyaWdnZXIN
Cj4gPiBoYW5kbGVyIHJlYWRzIGFjY3VtdWxhdGVkIHJlc3VsdHMgZnJvbSB0aGUgQVZHX0lOIHJl
Z2lzdGVycyB2aWEgcmVnbWFwDQo+ID4gYW5kIHJlc3RhcnRzIGNvbnZlcnNpb25zIGZvciB0aGUg
bmV4dCBjeWNsZS4NCj4gDQo+IFRoaXMgc2VlbXMgT0ssIGJ1dCBJIHdvdWxkIGtpbmQgb2Ygd291
bGQgZXhwZWN0IHRoYXQgUFdNIGFzIENOViB0bw0KPiBvbmx5IGJlIHVzZWQgZm9yIFNQSSBvZmZs
b2FkaW5nIGFuZCBub3Qgd2l0aG91dCBTUEkgb2ZmbG9hZGluZy4NCj4gDQo+IFRoZSBBREMgYWxz
byBoYXMgYW4gaW50ZXJuYWwgb3NjaWxsYXRvciwgc28gaXQgc2VlbXMgbGlrZSBpdCB3b3VsZA0K
PiBiZSBtb3JlIHVzZWZ1bCB0byB1c2UgdGhhdCBhcyBhIGNvbnZlcnNpb24gdHJpZ2dlciByYXRo
ZXIgdGhhbg0KPiByZXF1aXJpbmcgZXh0ZXJuYWwgaGFyZHdhcmUuDQo+IA0KDQpUaGlzIENOViBp
cyB1c2VkIGluIHRyaWdnZXJlZCBidWZmZXIgbW9kZSBhcyB3ZWxsLCBub3Qgb25seSBpbiBvZmZs
b2FkLg0KSW4gdGhpcyBtb2RlLCBDTlYgcmVwbGFjZXMgdGhlIGludGVybmFsIG9zY2lsbGF0b3Ig
c28gQ05WIGlzIHRoZQ0KY29udmVyc2lvbiB0cmlnZ2VyIChvZmZsb2FkIG9yIG5vdCksIHdoaWNo
IGFsc28gaW50cm9kdWNlcyB0aGUgYWR2YW50YWdlDQpvZiBoYXZpbmcgYSBtb3JlIGZsZXhpYmxl
IHNhbXBsaW5nIHJhdGUuDQoNCj4gPg0KPiA+IEZvciBNYW51YWwgTW9kZSB0aGVyZSBpcyBubyBE
QVRBX1JFQURZIHNpZ25hbDsgQ05WIGlzIHRpZWQgdG8gU1BJIENTDQo+ID4gc28gY29udmVyc2lv
bnMgYXJlIHRyaWdnZXJlZCBieSBDUyBhc3NlcnRpb24gcmF0aGVyIHRoYW4gYnkgYSBkZWRpY2F0
ZWQNCj4gPiBwaW4uIFRoZSBzdGFuZGFyZCBpaW8tdHJpZy1ocnRpbWVyIG1vZHVsZSBpcyBub3Qg
dXNlZCBiZWNhdXNlIHRoZSB0aW1lcg0KPiA+IHBlcmlvZCBtdXN0IGJlIGRlcml2ZWQgZnJvbSB0
aGUgU1BJIGNsb2NrIHJhdGUgYW5kIHRoZSBudW1iZXIgb2YgYWN0aXZlDQo+ID4gY2hhbm5lbHM6
IHRoZSBwaXBlbGluZWQgcHJvdG9jb2wgcmVxdWlyZXMgTisxIFNQSSB0cmFuc2ZlcnMgcGVyIHNj
YW4NCj4gPiAodGhlIGZpcnN0IHJlc3VsdCBpcyBnYXJiYWdlIGFuZCBpcyBkaXNjYXJkZWQpLCBz
byB0aGUgbWluaW11bSBwZXJpb2QNCj4gPiBkZXBlbmRzIG9uIGJvdGggdGhlIFNQSSBzcGVlZCBh
bmQgdGhlIGxpdmUgY2hhbm5lbCBjb3VudCBhdCBidWZmZXINCj4gPiBlbmFibGUgdGltZS4gQSBk
cml2ZXItcHJpdmF0ZSBocnRpbWVyIHdob3NlIHBlcmlvZCBpcyByZWNvbXB1dGVkIGJ5DQo+ID4g
YnVmZmVyX3Bvc3RlbmFibGUgaXMgc2ltcGxlciBhbmQgYXZvaWRzIHJlcXVpcmluZyB0aGUgdXNl
ciB0byBjb25maWd1cmUNCj4gPiBhbiBleHRlcm5hbCB0cmlnZ2VyIHdpdGggdGhlIGNvcnJlY3Qg
aGFyZHdhcmUtZGVyaXZlZCBwZXJpb2QuDQo+IA0KPiBJJ20gbm90IHJlYWxseSBmb2xsb3dpbmcg
dGhlIGFyZ3VtZW50IGhlcmUuIEl0IGlzIHF1aXRlIG5vcm1hbCB0aGF0IGlmDQo+IGFuIGhydGlt
ZXIgdHJpZ2dlciBpcyBzZXQgdG9vIGZhc3QgdGhlbiBzYW1wbGVzIHdpbGwgYmUgbWlzc2VkLiBT
byBJIGRvbid0DQo+IHNlZSB3aHkgd2Ugd291bGRuJ3QgYmUgYWJsZSB0byB1c2UgaXQgaGVyZS4g
VGhpcyBpcyB3aHkgd2UgdXN1YWxseSBoYXZlDQo+IGEgdGltZXN0YW1wIGNoYW5uZWwsIHNvIHdl
IGNhbiBrbm93IHJvdWdobHkgd2hlbiB0aGUgY29udmVyc2lvbiBhY3R1YWxseQ0KPiB0b29rIHBs
YWNlLg0KPiANCg0KTXkgYmFkIGhlcmUgaW4gdGhpcyBjYXNlLiBJIHRob3VnaHQgbm8gc2FtcGxl
cyB3ZXJlIHdhbnRlZCBtaXNzaW5nIGluIGEgY2FzZQ0KbGlrZSB0aGlzLiBJIHdpbGwgdHJ5IGFu
ZCB1c2UgaWlvLXRyaWctaHJ0aW1lciBvbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4NCj4gPiBN
YW51YWwgbW9kZSBjaGFubmVscyB1c2Ugc3RvcmFnZWJpdHM9MzIgKHNoaWZ0PTgsIHJlYWxiaXRz
PTE2KSBzbyBhbGwNCj4gPiBjaGFubmVsIHNsb3RzIGluIHRoZSBzY2FuIGJ1ZmZlciBhcmUgdW5p
Zm9ybWx5IHNpemVkIHJlZ2FyZGxlc3Mgb2YgdGhlDQo+ID4gU1BJIHdpcmUgZm9ybWF0ICgyNC1i
aXQgdHJhbnNmZXIsIDE2LWJpdCBBREMgZGF0YSBpbiBiaXRzWzIzOjhdKS4NCj4gDQo+IEkgYWxz
byBkb24ndCB1bmRlcnN0YW5kIHdoeSB3ZSBhcmUgaW5jbHVkaW5nIHRoZSBzdGF0dXMgYml0cyBp
biBtYW51YWwNCj4gbW9kZSBidXQgbm90IGluIENOViBjbG9jayBtb2RlLg0KPiANCg0KSW4gTWFu
dWFsIE1vZGUsIHN0YXR1cyBiaXRzIGFyZSByZWNlaXZlZCB0aHJvdWdoIFNQSSwgYmVjYXVzZSB0
aGF0J3MgaG93DQp0aGUgaGFyZHdhcmUgd29ya3MuIEhvd2V2ZXIsIHRoZXkgYXJlIG1hc2tlZCBi
eSB0aGUgZHJpdmVyIGFuZCB0aHVzIG5vdCB1c2VkLg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSYWR1IFNhYmF1IDxyYWR1LnNhYmF1QGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvaWlvL2FkYy9LY29uZmlnICB8ICAgMiArDQoNCi4uLg0KDQo+ID4gKw0KPiA+ICsJCS8qDQo+
ID4gKwkJICogTUFOVUFMX01PREUgd2l0aCBDTlYgdGllZCB0byBDUzogZWFjaCB0cmFuc2ZlciB0
cmlnZ2Vycw0KPiBhDQo+ID4gKwkJICogY29udmVyc2lvbiBBTkQgcmV0dXJucyB0aGUgcHJldmlv
dXMgY29udmVyc2lvbidzIHJlc3VsdC4NCj4gPiArCQkgKiBGaXJzdCB0cmFuc2ZlciByZXR1cm5z
IGdhcmJhZ2UsIHNvIHdlIGRvIE4rMSB0cmFuc2ZlcnMgZm9yDQo+ID4gKwkJICogTiBjaGFubmVs
cy4gQ29sbGVjdCBhbGwgcmVzdWx0cyBpbnRvIHNjYW4udmFsc1tdLCB0aGVuIHB1c2gNCj4gPiAr
CQkgKiB0aGUgY29tcGxldGUgc2NhbiBvbmNlLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWlpb19mb3Jf
ZWFjaF9hY3RpdmVfY2hhbm5lbChpbmRpb19kZXYsIGkpIHsNCj4gPiArCQkJcmV0ID0gYWQ0Njkx
X3RyYW5zZmVyKHN0LCBBRDQ2OTFfQURDX0NIQU4oaSksDQo+ICZ2YWwpOw0KPiANCj4gSXQgd291
bGQgYmUgbW9yZSBlZmZpY2llbnQgdG8gc2V0IHVwIGEgc2luZ2xlIFNQSSBtZXNzYWdlIChpbiBi
dWZmZXIgZW5hYmxlDQo+IGNhbGxiYWNrKSB0aGF0IHJlYWRzIGFsbCBjaGFubmVscyBhdCBvbmNl
IHJhdGhlciB0aGFuIGRvaW5nIG11bHRpcGxlIFNQSQ0KPiBtZXNzYWdlcy4NCj4gDQoNClNpbWls
YXIgdG8gd2hhdCBvZmZsb2FkIGRvZXMsIG9mIGNvdXJzZS4gVGhhbmtzIGZvciB0aGlzLg0KDQo+
ID4gKwkJCWlmIChyZXQpDQo+ID4gKwkJCQlnb3RvIGRvbmU7DQo=

