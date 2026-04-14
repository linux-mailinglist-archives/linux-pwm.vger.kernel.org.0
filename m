Return-Path: <linux-pwm+bounces-8578-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOQ4HhU53mkxpgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8578-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 14:54:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47D3FA30A
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 658343012863
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646903E6388;
	Tue, 14 Apr 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T9TEvwTG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68BC20DE3;
	Tue, 14 Apr 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171281; cv=fail; b=irzhY0E3dUMUH5auZiE4wfEiwyTnA9o0uP7CavRnGPfee1n0kzd5OHDnhvGJlxpeix0z1qKNDP5/627nLoBWSt1f9Ys8lVLWJNDkKHzJ8GcmxBzTnnWv8gsV91NV8IP8C5uiUmyUx2Ulafrn6vQLEScF9Xf+FwrA4lkMDuh6RTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171281; c=relaxed/simple;
	bh=+W3I3AHJOnV8czxIf47dXHOOjCKkxMchgnM8yg4znM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oldrs/a/nIdEnm3vP4Kfy738pkw4pKmUxLifubAZ3tj1Quh+LRCmMAcmwe57zYNBfOKl6ErcSwDqdV4YaFx0oZam+syikkp4UB+a5+uBde0ayU8299QgQuvunNT0IpHTMN1bE5SYVk8jyKGtlrDLX8i6FE6VA14uQOpBElpMtWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T9TEvwTG; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E5Vk0l1997990;
	Tue, 14 Apr 2026 08:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+W3I3
	AHJOnV8czxIf47dXHOOjCKkxMchgnM8yg4znM0=; b=T9TEvwTGVpaIjD/YZBwGt
	RmAD3jG0CdOW11hUufMqUI0Dcyom3uPCl/DHwXVxIcIMSZ+9ku9iwrHqoAEd4R8C
	8BdB5lrIwB+bxLd6auSz65+v3kY387Auhx21yjZaZhnjbhOXyE6jl/5mFPCpUK3z
	L368bI2+7me+gJFDnuhm8c6C+yQTng8as77KnOYAuPUYzFTDZxOKNA54VzK+a2l/
	Z109SeXqeX9KunPfrr7/XtUegeIpjOqIqSx2H6zG/VxPvNm2SBUJfdXye+R4kIGw
	aHUdHW77XZoaUpZEb6/3rI8GqhT6iMpb29xuxEFp8c37DV6Kbjjz8n/rRcxrn+v3
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dh84na715-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:54:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtaDU/opsR8+dYafpnMzwi1KGUfysqx0+VsIQ+HHX/DuOePNZZ/ZNfwUtV3VNIB4QuHvbAZH4vXcxNdrSbYVfZD9yJBz+kuHf3fnpJQx5z5BJleoUc6ebYScZ672CfmeHaSoqQLbNragDTeKYk3kXsJ2lSuLrskMAf06zZ3ae9shXBGUUfBeyTmqlFtPaU6Q2xWxsTasUDijQ3jMnzZtwCIMLYaoeLNN7Jr3ZFAxLaAJeTYAEMksVVZ1pBwXkNR15zQ/kNJPjCbx3RBnmOO6SE5aSu9M0EXpetNRcBQFBB/VnxnW7tZKqU5OV9m/NcSF9dbx0bEccKb9D5Okhj7R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W3I3AHJOnV8czxIf47dXHOOjCKkxMchgnM8yg4znM0=;
 b=YPabhQgvAsBNR7WkCMo1yqhY9p5jJRX0oN9sUcHl1GK2kAFAS+q+GJ6X3ONBcPtD5gMvqIItGB30xzkM/604TDo9r1nieeW/NXSp7uf9xHdbrNgUEqH9DH2WeMsT0aKS7Wf4jrY0d4XTH543Yw+iAuHnc6uQUiTC2/GH9ouoRcvGVgB0cfX5dpfa39yLUsXvfw3+glOG+HkEaR4sR06Ya/pQ6G8zHaUNSmUolphQhgfPhSAFWVFJirp6o9MSBlMazAjO7PzhUcZOuk+5VR9SGNMLDAgnY5CYN3Ck21z9bGOccEYuEIQPPQkTUCJmZ5xYERm7Yc+YvIJ0S6sxH7usvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA6PR03MB7734.namprd03.prod.outlook.com (2603:10b6:806:43b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Tue, 14 Apr
 2026 12:54:05 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 12:54:05 +0000
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
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v7 6/6] docs: iio: adc: ad4691: add driver documentation
Thread-Topic: [PATCH v7 6/6] docs: iio: adc: ad4691: add driver documentation
Thread-Index: AQHcyDWJomzupQjRrEa04kfReeoCrrXY1GkAgAW19nA=
Date: Tue, 14 Apr 2026 12:54:05 +0000
Message-ID:
 <LV9PR03MB8414B21076633842E8E3286EF7252@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-6-be375d4df2c5@analog.com>
 <9c36ee85-12da-41e8-b9ab-e32b7ec29e75@baylibre.com>
In-Reply-To: <9c36ee85-12da-41e8-b9ab-e32b7ec29e75@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA6PR03MB7734:EE_
x-ms-office365-filtering-correlation-id: dfd24307-9cb7-414a-c312-08de9a24e913
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 WHHayOlXNe/NRyCEQCB+C0GQXALobp1pNl7f2LyGqoO/h4fy5MrEi634SHqoyCbC6do0A23XFwIJnEUariNqDfJ1f7rKWxh0dnKdqHfXg6077zpisNaCFl71I1fAjDjv88OHob0vt4tFD1kHBAarUX54bLgF4B/UCftIEJ/w9jdKUFMe2S7NTkOo+VAxP1pB0m9yUxZNUM/Q+Kzyxsmm0s7ApHUx7f+Az2PzeG+2YGLslF7abyJx7Fug8P7Q0YHV6vWBTZmLsn/7n+Cm5uxx6SafHWpWD552EiNWpfqZ3YWGumJEYSAGzjzj3Jyl1J+0w24gLlM+7tAqD5z9R5m3DJj5UPAT0amV/rf1LMHXu4kD4PMS8OseE+KhaYxDbg5pdqAgFYoDPqaB/vpW+hjdYJLCrzqxcuv4LNDI+zuGBPC8OZ6Z0JTivWHp+Sqe6YbBZdQXvwgxVIb+RNEifYhb0ce6hpmSqED5xKTfEKjuTfPH35Fin3NQHMEf/6W+Vt18Tl/K1yJKt2qRzGNArWKFzcXLhhpjVFkAVO2rv35sYPVixCnIKasj5x22tdrLH9CwGu1fWCXsw9sjdkDquyLcpXyv/OwoaipVl+ZNxdD+Pt14K/BI5RqrLGzTC1XdPm0aMqy7XSY7lZ16dksP5SjTugsLe4h3z/ncAc30qs28jaW02yoEVHOEmIco7/S9XBqigmRQiyDPL/EhdvwBlmKVPR7I+zV4EuEZjSDkOlcpQosGRYhhmDUg8EPNVbjfifIPHNtPS8Q2pmw58X7SbHxpvFrJZqZ0QBg+tkzeUGFw1dR0O8gE0SrzgWWXc6PgxvIQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NENXS3BYWnRDUDJ3NElyN1NuQmlha2JhWlRsQTJWTTd5OTlIU05iWGR5Vktq?=
 =?utf-8?B?bW4vVG4rWkZtZ3FReWtDSGlWMU5oZFgxTTJaSERhVEN4RDVHck01WkM2NzVE?=
 =?utf-8?B?N1dIQnljeDJtRm5sSHQxQ2doV1VuMGlyNlJncUF5U1VVdmdZL1BITHVtaWs2?=
 =?utf-8?B?SUhBeGJ0ZlJuRWI1STZEb09tZEZLaU12Z0RHazlDMGFDWTN5eExrdXQrdjVq?=
 =?utf-8?B?MllsanRqQTdwMk04ejQvOWZMTmJtaWNWalIvenhpOG9qV3pHemZoS05UQzNo?=
 =?utf-8?B?amoxZlhYS2hsV3pIS2dLUW11ckVkMjJHQWF3UlgwdmE1MktCYnhKaCtwZzdZ?=
 =?utf-8?B?bnFPK0x2d2RvbGdXcVRvZnZQQU5XRWxmcE1DQXV0UkdWMUZGWGRUNUpwYVMv?=
 =?utf-8?B?M2lOc0tOVklRME9lOWlpTlBDOG5NdEdrVkZDOTJHMUx2ZjFNdjFGRVpQdUFS?=
 =?utf-8?B?UFBEOEd4M29UWkZqdnlXcXBBNWtySWpFd3QxK0c1WThWRXdTaWtXclllMTR4?=
 =?utf-8?B?M0dDWHl2SjVyZ1ZlZWhVelVXbE15ZWhkTTIzK0RwODRWSldqRFpmcmNPYlFV?=
 =?utf-8?B?WFA2L3V6K3p1c2NpcEp6SFJHSmZvb3BRNTBwSlBmQUlQaE9ZSFJiNGpaa2s2?=
 =?utf-8?B?ZFVXUEc2akc2ZENwdm1sNVQ1M2xaQ0djNWsxc2puWk52TmhSM3UrWXNpM2xE?=
 =?utf-8?B?dkN5NUgwODN2K1FjUGJObHlRNXJVVS9Vaml3TmhLbXViNHQ2Szlvb2VZSDhL?=
 =?utf-8?B?REhBNjFZOXNYRE1OQWVCTlozSHNPWkJMK1d6d294ZkZzdkhQcGVmNnFPTTgr?=
 =?utf-8?B?WjVFMzE5NndMeG5JTnI5clpYeXNkY1RnUkNCd003bGlobTZJencxZjlzbXFR?=
 =?utf-8?B?Z3BtVFlXeHRHdkFuQnF1bXpPN1F2NEJZelhLYmF4VVZjQVVla2twbzhIM3d0?=
 =?utf-8?B?Rzg1dU9PamNFSGJPMFl3c1c0TDFUZHhwSGtpb0xyVkpnVWpLcFdCOXhEZjJ3?=
 =?utf-8?B?UVJZTzI3MStycHZpQXBWNVQ2RXllc2xoYmRWd1ZrOWNSczhkWTNBZnk0emJB?=
 =?utf-8?B?MUVQZzg4VXZ6cWdEQ1k1NFU2NHQ0MzkyaXF1Zi9odXJiZEFQeGZCM2dDTy9m?=
 =?utf-8?B?RHBwQUkxUFBUUFFxTzVHdGM3ZVJlenQ0T21xSTZITGhTbE50VU5oVnYzS3ZF?=
 =?utf-8?B?enJqSjRCSjNGMFNuNXN2VGZuWTJXeThweDl2clJNMlpLOENBVUFucVlPeFRs?=
 =?utf-8?B?TkUzVVlOT0RJaDQ3VGQwOVpLL1hGS1NuNTNEMjluUXIzOGNBUmlFTE4yQXU2?=
 =?utf-8?B?Nzc1dW5xZnBweGgzNThicHc2am9ndkI3MktQL0V0ZWNuS3lVbGNSM29RcXRV?=
 =?utf-8?B?RHkzTnpjd0YwcTlvbXAybitpc1lIM3kyM1hEajJwN0RkOHZrajlpZ1VXS2s3?=
 =?utf-8?B?MGlrbnE4YVJCYUpMa3NPQzNUQzM4OU5KWXhlY3hmcmJTVnh0a3BLQWhtcmtm?=
 =?utf-8?B?MUtEZVdqOElqMCtCUXMzTHRqaVI4eTNoQTVHRVQyWnQ3bHczWWtFSkFaSW42?=
 =?utf-8?B?Smkwb3Y3NVhnQnpPNnFCU2lWNlhsNlFVdU1UaDJidHZhUVRaWFpoRlFsTVNJ?=
 =?utf-8?B?Y2VuUy9kbm9BMWt3WWVmalBCWXdOZHdHVjRTc1RXeW5idFZWbW5YWWlhaFU0?=
 =?utf-8?B?aFQzcWhTTHgrem1xWFVBa3RkYUlYdC9FSXlPb1c5VXp4aENWSTdRU3hYbVpC?=
 =?utf-8?B?aWN3UGo2ZzFNc05WYWdnNHV1cVMwT2VldDVoTmdOdWg5cUY3RU5RNVpCZGxF?=
 =?utf-8?B?RnZzaVpFZTFMZk0vLzhlN3IxTFV4RER4SllNOHlyOWIybDNmT1dTak1XcFo3?=
 =?utf-8?B?TUJVNk1JUHBxNXBjMTh0eWtPRldhU09PTVRXbDAyNHRFOEpiNEhKUzBZK1BE?=
 =?utf-8?B?SjNMUjVocVlCeXVqVm5jZ0l3M1UyOHBjZkphVjFmQ0J1UHVEWkxGN0ZKNitO?=
 =?utf-8?B?cmYvMEMvM1VoTDROQm9FeERCSVNSV1FBdVc4YkVMNGU5WHhuMjJWNnp5cWpn?=
 =?utf-8?B?UDlGOXhiM3Y4aTJiZXJldWt1T1dZNGQzTUtBekRTTWkzZENoeDlnNnV5MVdT?=
 =?utf-8?B?SlJ2QXVneXlyOUJSTzM2NGNBOTVkRW9Qd1dneWxsZlV6Q09Id0lYdnErVmlB?=
 =?utf-8?B?Mi9iN1pFeVFmTG9JbDg1SDJFTWw2T2tpYmYvL1VJbUJmV254UHhuU0FvZlZV?=
 =?utf-8?B?Zm9CcUQ0QjNnK0UybzR3Y0FpSUw2RzBocU5IU3hvalJBU0RzWHJvYVQzektJ?=
 =?utf-8?B?SGl0SFdrWitsNnhiMi9GSDlmL0VaZHUzVVJRWi9ZRGs4YXk0S3hidz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DkScqt/ut6uE/j5kFrKbuHEfwCjrToKzO04pKZsvBsZgZLLVqQlviVCPQCogmLQiZZF2mfh0elKL5RJe+0gOTi6xTIbXEBNl/qQlcQ1E0aHbfa5gO0Cpeky6k/+B4I81C23qrCcEme6edM10C8nn2kXwlpC+a0C6YQBEmHms8eVLbsOMM23SO1V2ejckxNuem8KcH4ONjBmpvIQ2Rwd/7fMfNdlCwIhdDC2w9qr6vHhvw03qPUffspiKV58Tt5AIlwFGPZYiNoZ6Q1QnsvwQBAJATD3g9LL2GnZj34ImPQmz5gIV8u3FkhOB3HZ984aEJNxzpwAUno9VeUPUCPuIYA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd24307-9cb7-414a-c312-08de9a24e913
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 12:54:05.2482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLgW9hKSEh+jhDugBWvph81Vi+Fl8c9UI3ChV1q+IxceHpxqMO1d72XBrLOeK0Iy5IqUl2mViwphw3jUjnHkeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7734
X-Authority-Analysis: v=2.4 cv=IMQyzAvG c=1 sm=1 tr=0 ts=69de38f1 cx=c_pps
 a=FTqHLmxhk7TnHmysD/QBZQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=IpJZQVW2AAAA:8 a=1nDf0xZJOO9T7ogfS_oA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: LsEfvRguM-lIKzyEtJOjRCgyWCvZXf7i
X-Proofpoint-GUID: LsEfvRguM-lIKzyEtJOjRCgyWCvZXf7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEyMSBTYWx0ZWRfX7LwyHLhCl0/B
 /edh7ptDRBbMydjrux3d0guEEGTaXw4TdqQkDfHJu6K0eMb0Zxhkj6Ze4IsfdEIAXdnUJmk0EJO
 Z43PYFMwsShwLPWdVlzj8l74T3/lng6fXse6vQhoCrgvNoVkQED3SrjkaC1EV9T658U4BqoPfgg
 KwAJRz73+kW7nYQbBt0ZrN0fE0XUgV7w4RSBIgvC2v8wbSje+fC+oXO0LycYNVIOO88uCAIvf6/
 Yen5aOq73Cukc9KxHb0nRpCp1xN2LxQN8zfoBmDfERAVZkoY5qu1BqRRC3bq7OvRLV4DbgJipO0
 OZatdjFimz81u3qdPOxmv6LPf92HqJRK0N0beWSqRcUlLjUpckKMoHZXqvYJvATurQO1mCngZqA
 x01TKE4BGXGv7lgRuugeyYykCEup7g54y5IgO/OCxU/Yuw0mDy6VLve9emLcJmOHfvqKr65m6fz
 c2/+uUfwgSkzurwY5JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140121
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8578-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:dkim,baylibre.com:email];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1F47D3FA30A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgQXByaWwgMTEsIDIwMjYg
MTI6MzkgQU0NCg0KLi4uDQogDQo+ID4gK0J1ZmZlciBkYXRhIGZvcm1hdA0KPiA+ICs9PT09PT09
PT09PT09PT09PT0NCj4gPiArDQo+ID4gK1RoZSBJSU8gYnVmZmVyIGRhdGEgZm9ybWF0IChgYGlu
X3ZvbHRhZ2VOX3R5cGVgYCkgaXMgdGhlIHNhbWUgYWNyb3NzIGFsbA0KPiA+ICtwYXRoczogMTYt
Yml0IHVuc2lnbmVkIGJpZy1lbmRpYW4gc2FtcGxlcyB3aXRoIG5vIHNoaWZ0Lg0KPiA+ICsNCj4g
PiArKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tKy0t
LS0tLS0rDQo+ID4gK3wgUGF0aCAgICAgICAgICAgICAgICAgICAgfCBzdG9yYWdlYml0cyB8IHJl
YWxiaXRzIHwgc2hpZnQgfA0KPiA+ICsrPT09PT09PT09PT09PT09PT09PT09PT09PSs9PT09PT09
PT09PT09Kz09PT09PT09PT0rPT09PT09PSsNCj4gPiArfCBUcmlnZ2VyZWQgYnVmZmVyICAgICAg
ICB8IDE2ICAgICAgICAgIHwgMTYgICAgICAgfCAwICAgICB8DQo+ID4gKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tKw0KPiA+ICt8IENO
ViBCdXJzdCBvZmZsb2FkIChETUEpIHwgMTYgICAgICAgICAgfCAxNiAgICAgICB8IDAgICAgIHwN
Cj4gPiArKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
Ky0tLS0tLS0rDQo+ID4gK3wgTWFudWFsIG9mZmxvYWQgKERNQSkgICAgfCAxNiAgICAgICAgICB8
IDE2ICAgICAgIHwgMCAgICAgfA0KPiA+ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0rLS0tLS0tLSsNCj4gDQo+IE5vdCBzdXJlIHRoaXMgdGFibGUg
aXMgaGVscGZ1bCBzaW5jZSBhbGwgdmFsdWVzIGFyZSB0aGUgc2FtZSBldmVyeXdoZXJlLg0KPiAN
Cj4gQWxzbywgZG9lc24ndCBTUEkgb2ZmbG9hZCBoYXZlIHN0b3JhZ2ViaXRzID09IDMyPw0KDQpJ
IHRyaWVkIHVzaW5nIDE2IHN0b3JhZ2UgYml0cyBmb3Igb2ZmbG9hZCB0b28sIGFuZCBzbyB1c2Ug
dGhlIHNhbWUgY2hhbm5lbHMNCm1hY3JvLiBGb3IgTWFudWFsIGl0cyByZWNlaXZlZCBpbiB0aGUg
bmV4dCB0cmFuc2ZlciBhbmQgZm9yIENOViBvbmx5IHRoZQ0KcmVjZWl2ZSB0cmFuc2ZlcnMgYXJl
IHJ4IHN0cmVhbWVkLCBhbmQgc28gMTYgc3RvcmFnZSBiaXRzIHN1ZmZpY2UgZm9yIGJvdGguDQoN
Cg==

