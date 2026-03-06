Return-Path: <linux-pwm+bounces-8201-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gb4LUDBqmlXWQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8201-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 12:57:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45821FF69
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E66307D4FE
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA57366568;
	Fri,  6 Mar 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L7CLRRtj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CE3659F0;
	Fri,  6 Mar 2026 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798164; cv=fail; b=M3WBmwGBGTDrZhwV3IWHzY8zCO5oypZjLfvgzPK/cv/6hPCpZporoZ0DCfuYPjAEKAVQR1KA2JqDbyzkj5U5lXThODpawyHEdcBaRaEQ8xvTjEb1leXm7kG0H9UAfzRKC2stE/arKT+Smv7dHbwDt/O/1qVTXpnZZzs8HPO7USI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798164; c=relaxed/simple;
	bh=kG9AJ0dEizZiwCnv+GUtxSB5lwp/TLUI27YEQlLITeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7x1oVAhvPoLorEy5owgzhMO9U+Tlv1j2NZvtWqKNySPcQPZDUH5VCODyyU/PZ1obMTaZgq4yJ9erXKxGT3hz4bGVuxdL8m2rGvSuZ/jrpiwrJ+PGQ300+sI/5ssF9SC+vbRrE+ad2kqQMgUqX86qSphMXZNpne4cvkp263/Jz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L7CLRRtj; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265tlrJ901047;
	Fri, 6 Mar 2026 06:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9WLe2
	RWLPSgFlkIZj+aVQqb9GV+GJ1hGk+ZH5UMtWzE=; b=L7CLRRtj3mqKfrJvEc9zF
	Jq1O+E4hzc9yG2DlFTJfzxm1ITVxht0EDdWbOsjYMxJm7DsOfqYSjhE1vbTRcUiK
	n7a3FRvD92QHWd0M/Ig9QT/Za3X11vuwFwgHZrTY+f3dRZcdyigx73PyBT5lYlQC
	S5HEoKvixEdfMtMb772TpKxNljRm0FbwkjLiNvwlcDGm7dv17PEY6tQ4RPx3InRF
	W3SjBJfhLg3Kl9BqxuEu7iBqV0ltts0VH+4sxCnqQO9LrrqBW3xxYjUoM6gaHDdz
	mOa1Jw4uuv5J5ooEf3mBxXwVCqUrhB7jJHHBWPPKwfmNFQ7nzYkOzsW3lWhQ0f4M
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cpk2drwcw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 06:55:34 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4VccX9kOSWYo8QDmKebjDPqN4N8mN3O7Q8lgNgXPsv+UP1bTyYv1bNmO+OfA3urTj5LjLNHLH/h4dacCfDzA1xzHHaXc5wXXxTYXBTM8GG5EyHYH8uZN3BV9o5udJcjfOtq8m7PsLo9y5XQmmuQaZvxLYJNJRQ/++BzlQjMH49KrUTuzV8ACZZRjTKleAafnFh2eeQ7cGg+kTlNywfXCq7ONj1YvS2L0NfcomNMSyq0HFJ2uDRdVgbnbZm8mzh9zL1b9IulfILgtacYMCk0yQXznJPldIxsZC4wk3m031ygn8VKALMceQUHEquHDK4yNVt70vcP8dqvbzVnsCmz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WLe2RWLPSgFlkIZj+aVQqb9GV+GJ1hGk+ZH5UMtWzE=;
 b=rqycApw8bbbim67GvL5dVuUlHHF0JDVLvhQzwYdzEGGHaWwOBeAlhK0ghP+uR5oo0o+0XCabXMQgVyykeDoxdbRRz2lDnBys9HaX0gp5VhMXoxuXFU24BpYpexY3FUpo1ia0BS5MBSXqF4l4fBzb+rA+nSOVZGpKbOE/mmgWHBtXq8fdHfs6E3MeBu2OqjkSjlsuT4EeS1FDaBU/tyTzqm6u/L4a4YCofzD3dA+nL0cEoXncDx384JmEKC/U/RjOWjDOsHCdF0XXCQ4vPd+9UimjZPi3b/T0WVqhfsasilXS1wGpzG3N6Uu99K7zSCVhkGx4srP9C0v4X/eVc590tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BY1PR03MB7191.namprd03.prod.outlook.com (2603:10b6:a03:525::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 11:55:30 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 11:55:30 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691 family
Thread-Topic: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Index: AQHcrJrnOQr61vQ0mEuBvbjSZ+4EebWgNqSAgAEV+KA=
Date: Fri, 6 Mar 2026 11:55:29 +0000
Message-ID:
 <LV9PR03MB84149F32D4CABA4D2827D85BF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
 <20260305174559.1ded5173@jic23-huawei>
In-Reply-To: <20260305174559.1ded5173@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BY1PR03MB7191:EE_
x-ms-office365-filtering-correlation-id: fd9d63f5-e6de-4709-1efa-08de7b7743bf
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 Im1Ococ+jBxZxBZ1OuDnL6hy/e14ezx0Co5RJ0GisTOig2rjVMtYp6DeDMNI8pb+XNAUf2Z/4A5sZeDAUKRJRNC+81+fiz68pogjV88TCKBvELR8t3mTvQeNEBLzyJXZLqoGo5cd5s1xSTguAUjcUz6n2EhyEGWzBy615hkF0fDl6wv5uZzK2QOJQzPZ9gBEzIgeYnrwcEYYf2pwipcNcvf+EZNDKI8+xg34YwdbnKfh885Rt3JOw4cmPnaw1ngRsmVL+woHkzxlUgEnwScs5hnBNDeLYU1DPTbmecdcJCosesdmNEGCfzW5flFnKNxPeY9ESisbPhF5uG/wDxLReOQkWjz4BU9S9SwwB/m8/sQvU30DEoGJT8S99XHNqdF1ULhMtZY6nX9Iyl9tW4SppqEiDqNEtGKcou1D3/kOiQf4W+fQMxJ2Wtb5A2SWsCphpahB0Wz/fl/TE2WbUcBgdaC0mOVCRtSuI3TOx0r2yPNdwahZS/FxoxYFPUECl594XUcm2Oyhq1wU9htS1JZ8I71RrtOphieiqkICpUUCuteqXK9u4b1H1Suj0pEvO/ZW6RwIxPoXBbHM8UTr8kIK6jsadlNTwhZUy8u95emSIW4/v0H0XzOJHoHlNqwKxATK4+qSBccNTV2cukerDJrIkQ4YQo3ykDs79gZc6g13RbhG3UolUfKvBJf7LzG0leDVloRfGSrJCdCs/7VA1ok2et7es6KbZ9eM692wpI/1zn/a9m+wO1BrpqwJjFcP9MOqv6paiiiNb5ezaJhe//f3+NxvxA5Z8/kWVuyM/MMMlzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cSHoPWXMZCurAtyqcNL0ci2sRR++HuJfIIDI+GhcaXoXHFNrsa7NfuLiGs?=
 =?iso-8859-1?Q?II0FSQAp+WBOu1QEc5IOc3z6LY8fC5faRguMNQiM47IhDQjjYHXUGiV3lH?=
 =?iso-8859-1?Q?ueiuacgCMFkukyroP0IVImPmv1rK6yzeQdkqADzFYPhApK6QvEb6YbUNO0?=
 =?iso-8859-1?Q?fdlRQwLz0SZJo7hwD75B296v666aiykzFpB3/aaKNhE6Mk54H5Di8f3hAW?=
 =?iso-8859-1?Q?0LJF/rItD67RuUldKgn1o+0T9ADV2vzAFz14lTtzZSIAnDhPvym+WNQ0lK?=
 =?iso-8859-1?Q?anasfgq+KSfQeGOz4n0sBcXm26rS5dPnne3QAUakfxrnSEzcjGVdjAIO4S?=
 =?iso-8859-1?Q?QKZK8VHL5c2b9Jw2YmI4AWXOp+tC6uoRLmtFnqaFD8koIIBcfSKOL3Qb4r?=
 =?iso-8859-1?Q?A9uWooQWOVVqLXlFoGwGf66lf7NBQdZmvLCwGiRhkoFCu8oFTmCFn4ZqVR?=
 =?iso-8859-1?Q?e5ZJx+/m+duE0Ua6zy/r36ZZ/KEm+qf18NnRFsL3ve4lDoiwtbUn78z3ff?=
 =?iso-8859-1?Q?TLFhiij5m1H1kyWv8cgi32oG1nu7buR/gzrHRW6K3SoKtsMoBtA+e11y2W?=
 =?iso-8859-1?Q?me+UXnt6wl41UFWb+P1uYPG+cPngYG0tGjVVeRD1dUTI7w9bEwmbZx1GP6?=
 =?iso-8859-1?Q?GhzvW1tubQ9BUqgKtkFJ5oNAhJJlmFWJpF2MyzbsFp8Q4UrhXfoEKSIKAM?=
 =?iso-8859-1?Q?PU5WnnRwj4JZ/u3DnguCa8KthqKZYrCys8vG/IDWewsM6/m1qRHIWd0RR7?=
 =?iso-8859-1?Q?UDPnacfUE2EPignCm5E2TyApmtYC4LeuqGTJCQPug6xIOTsh6CiG/4rdeN?=
 =?iso-8859-1?Q?N44u+fc/29gfZXnqUyR3CTDJUfP0KNfZ1jyPSrsLpbjRYRSw6wXC3TEbSe?=
 =?iso-8859-1?Q?Dr2+HbZ6uzN9EHh31FlQH/0hc5nYm4EdRkW3vu/1BTaNVfov8mrDe8xORH?=
 =?iso-8859-1?Q?W/UL0DQ2vfDNkI4mysg0ZLSWrV3ZananEok7b+uDo19jbgkLHlbHwEhe53?=
 =?iso-8859-1?Q?GpRrXuVt3LFuoyF8yg/kMn66Vi3iv+OMOT+32Qvpx4v1dCbuLC8qpCIqQu?=
 =?iso-8859-1?Q?V4Pgcoot5b9bGmY/qb4EzX30HpU7lAvRMgrdryjoBSg6TrNQlfx9lO8p5p?=
 =?iso-8859-1?Q?sx7pY4V11P7RCbsGtvRBDsdvoNBj4yjHoaqBsfejeY2tWxajMhklmo6pOO?=
 =?iso-8859-1?Q?Z6yb7SaflPbG6McyA9vGfyMrZt9Vyq5/W6nyLRbj5Ww/8aMbtLYuHIZNRv?=
 =?iso-8859-1?Q?d+hsMR4N+dMuFf0zoEf4O+q9rj0HTEx4rVNxFlimAS2wc5uT09lKQIWtJ5?=
 =?iso-8859-1?Q?W+ecTzE26drB0C5FgQwNcbvZb4KMowz/nrLss61olGo3hl/n8uRpqpxj21?=
 =?iso-8859-1?Q?1QeFKmdLMgHR++WR3B2LqMAGtrVVqUnMHMsQakCR/z2/V/4KfexFhZ62R4?=
 =?iso-8859-1?Q?RfXubz6qFfxye4cc83yZ3IOvgw8HXRllguuVcJWnfruPSm7YGXoz06L3zy?=
 =?iso-8859-1?Q?JjZeUWnSXmVWSg2QxKBd3dA5c1Aj8BDq+sNvCUkdw1qAio8ZYKyaXbaFzv?=
 =?iso-8859-1?Q?JbuS2RDkWVfAsJyH5Ri5g4usyrKbJQiC5DM7jfnlXqe0ZqdKubnUFeVgjV?=
 =?iso-8859-1?Q?T4WoLyb990rfYt0GbXFJZOq+7CFGQGcZHIzWYEmLJD18U/YQg73+CbvACq?=
 =?iso-8859-1?Q?TptWq68uVX/XiQMfYHa4MJ13hO6EAVIIuZCSZ7lNGRyAwRYL78luaA7zmO?=
 =?iso-8859-1?Q?Wv4DbaLmR5GnC4nsOYU3cYenO9LeV89fAOIRk0RFIjxSR6JkcLeCQoYXwL?=
 =?iso-8859-1?Q?P40p5UwaAA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	m81DsWLCwwABxSrb04S0QC3EBP+6nYsagCDzQOgKJdtvkRKUAii8Kr1e7R2K5GiftL3NRoMemz4KKDl1qGS/KeBfndw7ksQrE1IBWllVm0N4Q8EsURmXCG/Xg85QK1tpl5cXBzRMCj013NJgGQ+sxTAp0iLMjbLvFSeo4it9pRNj5gAn0M3yS8gK2CvERKRJJuqi29dCtmK7F8hejWz7dPPVLB/V1TMWej4mD5JQZlVXJViVZ0ZJIWXAoanoU4qh1fpSUYTg7YlbfHdM1a7I+C1WK/3lJyrQvnP8KEeE6u1s+RMti7D+GsaHOBh3N0+fuJ7OzML3tj2O3mvHot57/A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9d63f5-e6de-4709-1efa-08de7b7743bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 11:55:29.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1GXT0y/SqJ2uadAMZ2bGNWrnrQNsQ++y8KFxS5FJa1/uXmlZPOHtWEK1jBwtENJCcxR1i0k/mD3A8aei1aBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7191
X-Proofpoint-GUID: BuN9143tcWQDyvmQinkBOid3p8KQZTAY
X-Authority-Analysis: v=2.4 cv=LfAxKzfi c=1 sm=1 tr=0 ts=69aac0b6 cx=c_pps
 a=sujALEMa9QlLHAoAbbwPUw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=4yaQwLjC69nD0muN5WkA:9 a=wPNLvfGTeEIA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNCBTYWx0ZWRfX5tnFdSoMbtdI
 9QsdWeHCb0uDAOV/vz0wAG2gqODLs7xDChHf+NKxIn0M18hl8QUOoX/F4j1+wtBZ3wKxDSY12e4
 Jtw7QB8VNq1jjS5r+MlzJ7qxdxCEBRnQKY/kH7FZdDspObhzRYC+upqlDcpNsy6Fgd3KvbxdnkS
 BxMcjnbVjm/xg5U9j3a419cLextY1tjzQMY8JJM4/+BoNmVYGMXxblvY7OUr0pHO/yxzeSUjIi3
 B8GmKs7gu41L6WvYgGp0Inh5qeo5shGPvX5iQYxL73nryQwjRzL7ehp5xLng0w+OpBsYKS1ilmK
 7KdlI5Wl6H19wHZDCyz9tLyvdkYSCB0Nd+CNbEPpZIFVOHmGSCL5qA+atqqbkw3gm72yy/4n5kF
 3YCjazTxuqi536zxNVeEihwDjMD2L4uOZAdxDatSRDsEAlHBfFtR0S8MzJIpgkKDcJUw5VsLTYv
 arUELZaVD4t+L2hKsWA==
X-Proofpoint-ORIG-GUID: BuN9143tcWQDyvmQinkBOid3p8KQZTAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060114
X-Rspamd-Queue-Id: 1C45821FF69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8201-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, March 5, 2026 7:46 PM
> To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen <lars@=
metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>; Sa=
, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <kr=
zk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Uwe Kleine-K=F6nig <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.=
com>; Mark Brown <broonie@kernel.org>; Linus Walleij
> <linusw@kernel.org>; Bartosz Golaszewski <brgl@kernel.org>; linux-iio@vge=
r.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pwm@vger.kernel.org; linux-gpio@vger.kernel=
.org
> Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691 f=
amily
>=20
> [External]
>=20
> On Thu, 05 Mar 2026 14:23:27 +0200
> Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:
>=20
> > From: Radu Sabau <radu.sabau@analog.com>
> >
> > Add YAML bindings and dt-bindings header for the Analog Devices AD4691
> > family of multichannel SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> >
> > The binding describes five operating modes selectable via the
> > adi,spi-mode property, optional PWM/clock for CNV Clock and CNV Burst
> > modes, GPIO pins, voltage supplies and the trigger-source interface for
> > SPI Engine offload operation.
> >
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
>=20
> Hi Radu, I'm going to focus on mode... Mostly because things called
> mode are usually a sign of mixing up different aspects of the board
> design...
>=20
Hi Jonathan, Krysztof,

Thank you guys so much for your review.

Regarding 'mode', I agree that it should be something that could be modifie=
d
at run-time, especially since all register modes (CNV_CLOCK, CNV_BURST,
AUTONOMOUS and SPI_BURST) rely on the same principles of reading the
ADC result from the registers, the main difference being that PWM on the
CNV pin is required for CNV_CLOCK and CNV_BURST, but the board design
stays the same. Perhaps this PWM can be initialized at start-time and only
be used when CNV modes are being used. This would mean mode can
become an IIO attribute that could be set by the user at run-time.

However for MANUAL, modifications of jumper resistors on the physical
board is required for proper functionality, since the CNV pin needs to be
tied to CS in this mode. Would it be preferred if bindings would have a
'register-mode' attribute (the name could be better) which can have values
like 1(register modes are used) and 1(manual mode is used), and for
register modes, have a global IIO attribute that can switch between
them?

Please let me know your thoughts on this before addressing the other
Comments and preparing other patches.

Best regards,
Radu

>=20
> > +
> > +  adi,spi-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4]
> > +    description: |
> > +      Selects the ADC operating mode:
> > +        0 - CNV Clock Mode: External PWM drives CNV pin, samples at PW=
M rate.
> > +        1 - CNV Burst Mode: PWM triggers burst cycles, internal oscill=
ator
> > +            drives conversions within each burst.
> > +        2 - Autonomous Mode: Internal oscillator drives conversions, s=
oftware
> > +            starts/stops via register write.
> > +        3 - SPI Burst Mode: Similar to Autonomous Mode but optimized f=
or
> > +            SPI burst reads.
> > +        4 - Manual Mode: CNV is directly tied to SPI CS. Each SPI tran=
sfer
> > +            triggers a conversion and returns previous result (pipelin=
ed).
> Which of these are wiring related?
>=20
> 0 and 1 need a PWM wired up.  So describe a PWM. If there is one we need
> to figure which we want so indication provided by userspace.
>=20
> 2 and 3 don't need anything beyond bus.
>=20
> 4 probably does need a binding but that's about whether that wire connect=
ion
> is there or not.
>=20
> > +
> > +  vio-supply:
> > +    description: I/O voltage supply (1.71V to 1.89V or VDD).
> > +
> > +  vref-supply:
> > +    description:
> > +      External reference voltage supply (2.4V to 5.25V). Mutually excl=
usive
> > +      with vrefin-supply.
>=20
> Enforce that via a rule as you do below. No need to document it here as w=
ell.
>=20
> > +
> > +  vrefin-supply:
> > +    description:
> > +      Internal reference buffer input supply. Mutually exclusive with
> > +      vref-supply.
>=20
>=20
> > +
> > +  # AD4694 (20-bit) does not support Manual Mode
>=20
> That's a driver thing. Not something we want in the binding.
>=20
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: adi,ad4694
> > +    then:
> > +      properties:
> > +        adi,spi-mode:
> > +          enum: [0, 1, 2, 3]
> > +
> > +  # CNV Clock Mode and CNV Burst Mode require PWM and clock
> > +  - if:
> > +      properties:
> > +        adi,spi-mode:
> > +          enum: [0, 1]
>=20
> This is backwards. Define these as optional properties and use that to
> limit what the driver can offer as ways it can run. Maybe they
> only make sense together in which case add that rule.
>=20
>=20
> > +    then:
> > +      required:
> > +        - clocks
> > +        - clock-names
> > +        - pwms
> > +        - pwm-names
> > +
> > +  # Non-Manual modes (0-3) without SPI offload require a DRDY interrup=
t.
> > +  # Offload configurations expose '#trigger-source-cells' instead.
> > +  - if:
> > +      properties:
> > +        adi,spi-mode:
> > +          enum: [0, 1, 2, 3]
> > +      not:
> > +        required:
> > +          - '#trigger-source-cells'
> > +    then:
> > +      required:
> > +        - interrupts
> > +        - interrupt-names
> > +
> >

