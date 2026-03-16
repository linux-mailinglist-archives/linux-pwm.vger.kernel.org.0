Return-Path: <linux-pwm+bounces-8269-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFQNMMb/t2k5YAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8269-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:04:06 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC7299CA7
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C912301725D
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B11DE3B7;
	Mon, 16 Mar 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hvupj7k1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34100EADC;
	Mon, 16 Mar 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666118; cv=fail; b=V8zNbHkdayD6vQUboeFRZB+Fl+IFa69fOmd9qfXF3ThsFm7W8HwOg7w0slBH0HbZFfBsfsExaGvTTZCXsbsIfYvLxqlC7RweQz4zj/CwVMJWxsWPEoNvH5Sq3moDg5M0P61MWDlwy5cnBKnQzQksJKsMTTKS1WF9mWKNy8SqGXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666118; c=relaxed/simple;
	bh=TOxsa8XyTurvxyxoang3O6+otHJw/O7beOXfuAwEDkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XXptkc99VEiKjhjfcnHwv8XFHUbjM8w+PiUgr7Z9+64+nkIMpVeKaGjGJEsaNB83VACpWnnr79CNknLYXRiTIf0DZ7xPXhP7Gq68ELMsNue77zCXwb4Qv1rbeCUsSkQ66W7+eoP2InZWx3gj6sOimybJzcE/7Z9S+7tIvj3FoFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hvupj7k1; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBe9Dk610707;
	Mon, 16 Mar 2026 09:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TOxsa
	8XyTurvxyxoang3O6+otHJw/O7beOXfuAwEDkU=; b=hvupj7k1NS0uQ9EGuKjXG
	opDxZyxB1JRjV9HBMWh15xGabbNcKA2XsTvmIFDattniGWvJam+U92P2EaI0rmMV
	YDcFdVFIQwnapodjDU9D4Bzea+eL/H9hZPH3VhO3ofE26BVSWCirYBh8yQBf/9kA
	nd2xGgWyerfjuORfGZc0oI8eH3GiYFLAnRZDrxUpBF6iVFJbXc7RwSdEc3vguUj0
	jrMgcGA08g7lXxT5WaT9NQsWVkPR0RCIxI666NadRL031BcV5L1qFnENOCZopwfC
	aR8iZkVn16r0QLr9nRxDEa0U2S257gV2fLCXY/r3Pqdo9CqJqbVf3MzQb6PBCR4l
	A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2em2dua-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:01:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIWITewiAmHopC4PIvueyx2tBvXOesOjlAEY8UuFyy97PuVko1RgWwDCMUEUYNbRUeact0RAX3pRGmLQin4l9bHwwi4uTqQbfcXotmDhDqLEROfB02EVeMnXJKTicT+Yy0jLnU8lnpfTC9s3enW2tU8rhG8SryMEhsKUrqVfB8zwin1sS03b1328hyKRLUELqNBRkx2oW7J6hDXYgb70DKilKJVHupGESpLhizBuS8008LV7RLGgFduaVOqnQ76fQ14TOodvfh73L3W41ZoMTK3bCTxjtlHktuQK2fDjHbH/JDflvvbz0Frxc59+9qeGuUMpr3SXTTGPzncJnBlOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOxsa8XyTurvxyxoang3O6+otHJw/O7beOXfuAwEDkU=;
 b=J5TErac6z1EmZoyIEgkI+uwjfNxuCz2Cq6CIOzLMx3Ei4+bpAPpWtq1fxm853r7yia2LTjUTH96YEeYuwch2p/WFSxwoREk2aTFqWKlZHRGB5rTFWWVCOaSEV8hxj6UqQNdOXqnssKdP1rzvVCWYJ82j4cKaqMps6imWw4Fk4ePQZEhVvSS/oDMxrIFu9fCXmU2qHMAADHZtNV+N6p1/S1yjUrItOvbvawTHIXoweRyU5Er4MBvXyAUXjmJlCBubtkrEaIm7uwHsurwO0lWpU0yo8RHoOD9dchBP6PC9An33XWH0Mh6Ei1Nzo7B1mxmwEKc1euePMdm4Sx67djVfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH3PR03MB7458.namprd03.prod.outlook.com (2603:10b6:610:198::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 13:01:00 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 13:01:26 +0000
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
Subject: RE: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcstE9wdxbJGrMMUOmE/HdBho5IrWuO94AgALkggA=
Date: Mon, 16 Mar 2026 13:01:26 +0000
Message-ID:
 <LV9PR03MB841449F615E4B08570E9F9E4F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <aa83d2ab-a531-4f3c-869b-85c323c469c7@baylibre.com>
In-Reply-To: <aa83d2ab-a531-4f3c-869b-85c323c469c7@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH3PR03MB7458:EE_
x-ms-office365-filtering-correlation-id: e729c369-dac7-4452-8390-08de835c2226
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 soBSY7jNZc6SduUGn3RBGw1bSd9Gd+9/8Wgza0eUrezZ/eD5H9lJoT743vfFD4/yabmF2ZAyyLBmAWWTh4CFth4UmWp88pswITmnt5zPz+iSAlpu/iR+RulLsetGoA4zTA5Cynvw/roYHWJULifQYJJJgu1QQu6yoLXlO5KR0RjgxAmwpKwmy61rwzsYZ62HuVZPjH3CEWlTI8dvHXArxQlI9nzDDUaCaJxUp9ErPd24EFVk0BLPdHEakePgYRG/RD1bhVHO7paCpaT0qY8IT+2xAs2ft3U2f6nzzwvCZRXF3Pb4Ezy33ZxsqFxkaBhmcHZPqusTb14tAWK04SdJ9ufdeNGNeG/Fn1XUi0m4qvWgWuWsRTV5sgSplSPTXUamdqBEVkQSJJXcb9sobYq0f2TTpC2KV+wEzPLx4fozOmdKojDQzreB3/Fsvaq6B4zLBzl4S90gs03fDRQZilekBHrt2DuRQdiNvREgJRW2YlHszTolYvCmDqGwHhQ3tt24lX89v047JkeE1wcH1MljO0gZYr0w9CQ8f6IFV98rtyqbi7UaL1nRvxKC0JV6jsydqh+yqVbzM/XxrZHgUq882Teyo+DI5JHGpnrS/M96MxVVzoX8Rf11wRlA6LbytG/XwxVJDE8CeH5bgfJs4vJnbdV3LCcj7yAo3bnqDe1/UB1rFbFLdJ5vrvQCwTwcowfN3s1nEvuSnmcr1P3EKhLGkIjH9lBuIktz7chLQKOHJbD/3XBWTjMObTZO0ln36aIe0Q8v8N+8ScIPK+6KgJcmMxet1nfwMmMiFb2JKkxG1phqTyVw5RJGNbDQTdx/Nt+t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejRBUXl3diszTE94TEYzMnZpd1VqMEUvaHNwMXU0dTNwYkFOd3N4OUxFMS9t?=
 =?utf-8?B?cDlzYnVsVHM1cG85dzZmSnF0SWlBZGZjYzkyY1lpdjJjRklNaHlNM01mdjZV?=
 =?utf-8?B?M2hOOUcybGZGMkdxNDgwVnJkWHFzdS9PclRPYzU1Tm1YZWRXRVhtVEI4VzFs?=
 =?utf-8?B?YzEwejM3S1JvT3I1TmtiNDNtc1E0VENVVzFyczByNGxmSlhEWGJtd3JMcGZy?=
 =?utf-8?B?MDU2T0Q3T1RLQk1JaSt0c3BOSFZsTnBSNTVUSEpjNkptQ2pybzZVa2UxWjl5?=
 =?utf-8?B?ZCttUUJRanYyZHhrVkc3Z1FsZnVUd3hSU0Z1SS9BL0N0OUtzOHFXWU8wNU5F?=
 =?utf-8?B?d0pDdXgyMURuT0tWbW8ySzlPV2RwdFliODE1SGFkM2NyK0oxR2NCcDVSTk9M?=
 =?utf-8?B?SXRDeCt2VHRNQ0FQTUdTT0Nvek85bWxheURzbEFPcDJ5ZFdDbmNMeW1ucERM?=
 =?utf-8?B?N2FpbHgzcnphNjFYbHkzamg3ZzFwTXdJN3BuTnByc3RJbk5MK0lVSytlVjZ1?=
 =?utf-8?B?SzRIbno4VC9rYXBnWHZyb2RSKzI3T3dkZDYxY09GVjNWekQveTV2NEw3bUxY?=
 =?utf-8?B?WHFsRHhDRUpsc1RBSmgxMW5Edjl3Qk03T1d6STJUSnBOTDZBdS9zZHdENS9i?=
 =?utf-8?B?bFJlT3ZLVDVVVUlIY1lDSkIwUGxKdzR2dFpQRDIzL1gxSWExalowUHU2MExq?=
 =?utf-8?B?MnNydEFZajNaQTIxOUtJNlArMUJualNkMFpzU3NObmFoRFNQVXlTY3BtWW5J?=
 =?utf-8?B?ZTJwNnRTZGhpbjFMZDdVcU9mbGJDRVBKY2MrbTE3RWZTTHJveGxieDVMV1M5?=
 =?utf-8?B?cktDQjdPNDEyUFBOSnlVWGN1SnJlbDJkWjFqbXE4TWpOdFVUWHEyVWtVSXZ2?=
 =?utf-8?B?VjNnbmZwL0RxY1RoVWxSMXRoVFdTN3dYd0FEb1dETXFXZHRFZVI0bFdqYjlp?=
 =?utf-8?B?NFhFa0xsQVF0UmFqTmc3Uk9jZ2ZTc1BRdytLRi9lRlFtdmpqMjlpYnBuNVFk?=
 =?utf-8?B?N2hNNkg5dWE5WU8yOW9sQitBVjhKRUFRSVp2NmtxT2VzNFE1NXBGc3FybVd5?=
 =?utf-8?B?a3djRHpKUE5VY2tnZ0ZrRmFlb2dUL0ErTnUxeVJIdER4VkdXQkVzS3BXSmlK?=
 =?utf-8?B?MHI4QThTZDVWYWpNMlNEYktNejUxeWxnZDcya21leDVkWjNnUkpBd3dlcjZB?=
 =?utf-8?B?bFdzNjF0TmZhS1ZQRFplcjlWSE92VVRYVVBBcDhaZ3NSaWpQYXp4ZkVpQmtC?=
 =?utf-8?B?ZGExTjRoUkdnQzE0L2JMK21tQ2ptYnFkVDlRSlk5Wnk0bk5TNVNWZ01qQjBG?=
 =?utf-8?B?eWxKZzVQUnp1N2RtMGtSZWp5c0orTTlLd3BFZ08reVhGUW1zWWFsWlU0aVRB?=
 =?utf-8?B?M1diUjBMK0x6Q2lBbUd4YmV4Ry9lRFQ5cW5LQ3Rha3g1Wmk5RFhXSWF6elN0?=
 =?utf-8?B?Ri9qWVFhMnd2RHJxcHRKU1VkT2tIY0FBNDhqWGlkRWVXcHNNZG5LbEF1Wnli?=
 =?utf-8?B?VzZ3UVFmZ295ZmZzTVI2SjEzOU9VOGJDampad2Y2U05qOTJNOVh5NzRRRktU?=
 =?utf-8?B?Rzg1eWo1MWNFM01rUnBicVI5ZU84U3JzV3VYTFpSSFBuVFBSY3J1TE5tNlFD?=
 =?utf-8?B?ck0rWUs1ZnJFM1J1a3pRWVlzSUd4UUQ5empKMXQ2TUxIbW5rdk5jRHlvTHN6?=
 =?utf-8?B?RncrcGpWOC9MR0daamdFRHZ0UEVwQURCZW9ZMHFxNmJhSGpRZExlUzVHMUNh?=
 =?utf-8?B?MGVtbWlaWnEvckVlQ21OLzQvK3YvMHdwMjAxNXNMcTl0azl2bFJDRktTeVMr?=
 =?utf-8?B?azFlTDRKQTdDdks3dThDaTNHY3c0NFBNdUdXbzM4aDcva0lla0NVd0NaWFFK?=
 =?utf-8?B?VFRTQ3hKc1R0REZudTRyZUhSd042bTNwalZQdmgxb2YvYW1Nd21OL3I0OG1S?=
 =?utf-8?B?bWlEMHVIZnpDa2VFNkNyZmlIYkIrUXpRMDdVQlp2Z1ZxdFB5RFF3Uk55dlk2?=
 =?utf-8?B?elFWNHJTTnlhTWZFU0FIYmw4YjdhN1FGcXU1RndiOW9UUkZpZDY3Y1BhVldE?=
 =?utf-8?B?UjBOOEJqTThlcG80bEE2dXA0NUhjbFVtdmZLbW0wVWpnMnVTb29kY1k3bDVl?=
 =?utf-8?B?eHhVeW8zbzF5d1Ywa0ZkanNyekxmU0tNdlY3VUh0dG52Q2lybUZTalZJcVpH?=
 =?utf-8?B?ZGdhZk5NWFF0Qnh1dlRrUjJwRWM1bWthSnhhVzV3aVNURDlnVldlRUtwS3Zj?=
 =?utf-8?B?YkhlL25KUmJlTUxqSkN1a3NmYW9tcllyNEdHckVqc3EyZVJBRC9KdHFXWlJO?=
 =?utf-8?B?NUZyeENqZVJnRFZRUHlmNFcxSXZuUDhvQjFVN1k5VVRDdm9PRFB1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wHIzRvSR9JNUTx+IaI6/ozO0V9roYdmsrEenI85IUVLANKFtHcgoCWJAwGimHtO07akH4cZ8n+AtiXk4RTenTmTnJW2SG9hV5fWSRGi+le92fOmOf/OAoUxUbyr8E/nEkpVqcWPrv2mJI4XxLTxShE8XfKd5wYNSv1nP1sG5dM08WlUE0Ytr9UHjxk8TtRiArGI4JvNbaIRVtiJLk2OvTEvHAXzyoc8P+n4F+jZB5NV3s+ekPRihmwyr8U340hdmS5MazMbI4ymCBrGrch0s1i98hUK5fjD3sMFmmll3n/j5l8Yh4CQYA4xs8J+WiUSGjc3wFL4u/5NHc29tMXa20w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e729c369-dac7-4452-8390-08de835c2226
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 13:01:26.5705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXQ8QWNwOSBGpoM36tF3FwNEMSBytnSy8ippoY4D70ehQrR2VdX7KEATdcbwKYTnc+iA9s9vYjHguIi1DJXdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7458
X-Authority-Analysis: v=2.4 cv=etTSD4pX c=1 sm=1 tr=0 ts=69b7ff2c cx=c_pps
 a=tYxZZT+6B+k9mAKHHpnGSQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=ciXU6tPWEMWKVZ_5X7wA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: yePsvKl7IYCWVbhIJqpZ0ml_Ey4KZTAc
X-Proofpoint-ORIG-GUID: yePsvKl7IYCWVbhIJqpZ0ml_Ey4KZTAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5OSBTYWx0ZWRfX0LBsjcuQYixG
 eqLGxtfi0owm+SkMc1noytlCAGzfB8nD6mOtKMsYUbA50647uXDKfx44KGsuvnC4dxrai3kyJjr
 GxY0cUBgajiK2QxoyyyJ5bSlm1ACQ4Rv4c9myhQi9e5Rv5cIfaDdCO7u3bAhip7ucjBn+Wd51mS
 iJ41xY3bR0ZDirJUz9R2mDJabnRAu57dDUC46R2bVr8MtIENUwllWYeLABdYlKyJGeGeqDxn8j0
 409gT+p6qE9itMSrevYqWLq4GUU8ALQETU1NNDrTdH0dg/AGJwdu2xwQqfIDTTjHWKU3tKCvMaF
 hqpF0iSNN1zk3lGX5eG88jOZBCEuKP33UC0EEJXYEtvWaNrQwQHsuTT5A1EjOIon/bdxHJum6c5
 Vp+iqexSzm/cHIZKgUDzSt8TtuI47YtzwslP1J+jE0JD1oyDhvi9p2E7kYZ7Pwk9LXnPJl2gwf7
 0vJULukwjI8HnTPUGNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160099
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8269-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82BC7299CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTQsIDIwMjYg
NjozNyBQTQ0KPiBPbiAzLzEzLzI2IDU6MDcgQU0sIFJhZHUgU2FiYXUgdmlhIEI0IFJlbGF5IHdy
b3RlOg0KPiA+IEZyb206IFJhZHUgU2FiYXUgPHJhZHUuc2FiYXVAYW5hbG9nLmNvbT4NCj4gPg0K
DQouLi4NCg0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGFk
NDY5MV9tYW51YWxfY2hhbm5lbHNbXSA9IHsNCj4gPiArCUFENDY5MV9DSEFOTkVMKDAsIDAsIDE2
LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCgxLCAxLCAxNiwgMjQsIDgpLA0KPiA+ICsJ
QUQ0NjkxX0NIQU5ORUwoMiwgMiwgMTYsIDI0LCA4KSwNCj4gPiArCUFENDY5MV9DSEFOTkVMKDMs
IDMsIDE2LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCg0LCA0LCAxNiwgMjQsIDgpLA0K
PiA+ICsJQUQ0NjkxX0NIQU5ORUwoNSwgNSwgMTYsIDI0LCA4KSwNCj4gPiArCUFENDY5MV9DSEFO
TkVMKDYsIDYsIDE2LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCg3LCA3LCAxNiwgMjQs
IDgpLA0KPiA+ICsJQUQ0NjkxX0NIQU5ORUwoOCwgOCwgMTYsIDI0LCA4KSwNCj4gPiArCUFENDY5
MV9DSEFOTkVMKDksIDksIDE2LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCgxMCwgMTAs
IDE2LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCgxMSwgMTEsIDE2LCAyNCwgOCksDQo+
ID4gKwlBRDQ2OTFfQ0hBTk5FTCgxMiwgMTIsIDE2LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hB
Tk5FTCgxMywgMTMsIDE2LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCgxNCwgMTQsIDE2
LCAyNCwgOCksDQo+ID4gKwlBRDQ2OTFfQ0hBTk5FTCgxNSwgMTUsIDE2LCAyNCwgOCkNCj4gPiAr
fTsNCj4gDQo+IENhbid0IGhhdmUgMjQtYml0IHN0b3JhZ2UsIGJ1dCBJIGd1ZXNzIHRoYXQgZ290
IGZpeGVkIGluIGEgbGF0ZXIgcGF0Y2guDQo+IA0KDQpXaWxsIGhhdmUgdGhpcyBjaGFuZ2VkIGhl
cmUgb24gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgaWlvX2NoYW5fc3BlYyBhZDQ2OTNfbWFudWFsX2NoYW5uZWxzW10gPSB7DQo+ID4gKwlB
RDQ2OTFfQ0hBTk5FTCgwLCAwLCAxNiwgMjQsIDgpLA0KDQouLi4NCg0KPiA+ICsNCj4gPiArCXJl
dCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2OTFfUkVGX0NUUkwsDQo+ID4gKwkJCSAg
IEZJRUxEX1BSRVAoQUQ0NjkxX1JFRl9DVFJMX01BU0ssIHJlZl92YWwpKTsNCj4gDQo+IEFzIG1l
bnRpb25lZCBlbHNld2hlcmUsIGFsc28gZXhwZWN0IHRvIHNldCBSRUZCVUZfRU4gaGVyZSBpZiBu
ZWVkZWQuDQoNCllvdSBhcmUgYWxzbyByaWdodCBhYm91dCB0aGUgUkVCVUZfRU4gZnVuY3Rpb25h
bGl0eSwgaGVyZSBhbmQgaW4gcHJvYmUuDQpUaGUgaW50ZXJuYWwgcmVmZXJlbmNlIHNob3VsZCBi
ZSB1c2VkIGlmIGFuIGV4dGVybmFsIG9uZSBpcyBub3QgcHJlc2VudCwNCndpdGggdGhlIGRlZmF1
bHQgcmVzZXQgdmFsdWUgKG5vIGNoYW5nZSB0byB0aGUgcmVmX2N0cmwgdmFsdWUgaW4gdGhpcyBj
YXNlLA0Kb25seSB0byByZWZidWZfZW4pLg0KQW5kIGlmIGFuIGV4dGVybmFsIG9uZSBpcyBwcmVz
ZW50LCB0aGUgcmVmZXJlbmNlIHZvbHRhZ2Ugd2lsbCBiZSBzZXQNCmFjY29yZGluZ2x5Lg0KDQo+
IA0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
IkZhaWxlZCB0byB3cml0ZSBSRUZfQ1RSTFxuIik7DQo+ID4gKw0KPiA+ICsJLyogQm90aCBDTlZf
Q0xPQ0sgYW5kIE1BTlVBTCBkZXZpY2VzIHN0YXJ0IGluIEFVVE9OT01PVVMNCj4gbW9kZS4gKi8N
Cj4gPiArCXJldCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2OTFfQURDX1NFVFVQLA0K
PiBBRDQ2OTFfQVVUT05PTU9VU19NT0RFX1ZBTCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIHdyaXRlDQo+IEFEQ19TRVRV
UFxuIik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2
OTFfR1BJT19NT0RFMV9SRUcsDQo+IEFENDY5MV9BRENfQlVTWSk7DQo+IA0KPiBXZSBzaG91bGQg
bm90IGJlIHNldHRpbmcgYW55dGhpbmcgYWJvdXQgdGhlIGdwaW9zIHdpdGhvdXQgY2hlY2tpbmcg
d2hhdCB0aGUNCj4gZGV2aWNldHJlZSBzYXlzIGlzIHdpcmVkIHVwLg0KPiANCj4gSSB3b3VsZCBk
ZWZlciBhZGRpbmcgYWxsIG9mIHRoZSBwd20vQ05WX0NMT0NLL3NhbWxpbmdfZnJlcW5lY3kvR1Aw
DQo+IHRyaWdnZXINCj4gc3R1ZmYgdG8gdGhlIHBhdGNoIHRoYXQgYWN0dWFsbHkgYWRkcyBTUEkg
b2ZmbG9hZCBzdXBwb3J0IGZvciBpdCB0byBsb2dpY2FsbHkNCj4gbWFrZSBzZW5zZS4NCj4gDQoN
CkkgdW5kZXJzdGFuZCB5b3VyIHBvaW50LCBidXQgdGhlc2UgYXJlIGFsc28gdXNlZCBpbiB0cmln
Z2VyZWQgYnVmZmVyIG1vZGUNCmFzIHdlbGwgc28gcGVyaGFwcyB0aGV5IHNob3VsZCBiZSBtb3Zl
ZCB0aGVyZS4NCg0K

