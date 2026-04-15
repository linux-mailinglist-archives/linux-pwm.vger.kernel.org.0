Return-Path: <linux-pwm+bounces-8587-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Js4ODyS32nYWAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8587-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 15:27:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D1404C54
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8B5302AC32
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCD3A7591;
	Wed, 15 Apr 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oZyjMB6R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB42D9796;
	Wed, 15 Apr 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259638; cv=fail; b=HpcRJq1X5jjaYOI28homA1r//UKZPw+Z9jPcaTu4SYEHsa7ttXKOHhnATGJ3uYnStqTiZlwRpjI8SiBzaLgjvedSD1K2I1XnzeMkbomE4gufdTn/aZF2UAcL/lfbR/5huqSxkeJER+vwI+7UNRMZZVCk2r1GENUQeMKC4Dytabs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259638; c=relaxed/simple;
	bh=2dCSQn649mztq8bKPfuEtT5aCwY4wPTFnvMUz54M8xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sxn7whCWCLRJEZoorjMZhffP+YAP4VMjfBCU2T+BcfCaAY8HmUy+2UlKRT77PVyJ589/Hwd8OYAzYnmbcQEPGSHXeTIBTzQeyDo/7s8Ee2Zbwi3RQ96mzO4d8mnXY4980OOphvqRXpZw+XHpdUmANnb4nkpY9KtUidcoiQiWDUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oZyjMB6R; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F7heAZ679991;
	Wed, 15 Apr 2026 09:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2dCSQ
	n649mztq8bKPfuEtT5aCwY4wPTFnvMUz54M8xg=; b=oZyjMB6RwS87F1tSLcfDs
	C5l7uLhgQsRuFaghFlyNVPhvkejvn7mSVMC1QKdrkZikZC/c5NBT+AcjTtIK1OWP
	JaJoe4HiLD/FImpyMWDo2u8LYrhn2gf1/Ab69HIQgD0VwAvyBqbigQj47E+COks8
	8lTP8AbwCe2VDpWnRZlS8bSnMJxpb5Mj7QCF6LkPTbB/ZyOhU0GM14Gq1fhvFUYx
	nRLjTvJv00nr4uNpjj7fxPrlPuOjehqw5AMHBtmt+v4TJrR4/BQcwbIAh30OtQ8r
	g7+mUhadWU39+OaXjmIJdScNrtz99c0wLBq9s6ep7VS+RuEBwMCq3z3sydrW6ygx
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dh84rfed3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 09:26:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKtC4aHeS5VbnFThBVjXwDHtj3ehHdgOAw+ar8KdwhI/QPMGv6K+a3U3BHK7TyOkyqpSKT+nXWxccY23YxLNArzVHV7yTmie7OYnttKV/RtJV9uyFcH2L1kw9StHwfPnOFs+eAoRWkCAVmQx1dA7jX20MwkZAIy1aQcBXb8jMqtMpQ7gWVrGtQ08WsqCLHCQFGtuObcmt0vL6GBln99Z2xV31z4Zs8aI0beyZ0sYXCD8bYk+J+DdERXF03Rr2Joy7D/gefFRxuZS95It8o/KlTsNZLT2NBBlgjXrs+BntdieKzWztbq/TbTik3scKBUs76KibTI/L7bbW2uepLYQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dCSQn649mztq8bKPfuEtT5aCwY4wPTFnvMUz54M8xg=;
 b=cwFWiaAxZNt87TvTtcpxLUnNzd0fyg/RJ2wC9nMdal9zWeUPejn01Vxl8z171a0RAwy4MV/tLf4aXRlKh9COWLKPMFiV+d7s2vxsZNxQ24RKy5DfyBPnMEGwLUf8upXzHDYk8jYiHufBb1K5z9V50I1W2NnOXLtP2eXVVX+M+PgEovqD1ui6zAyEto2nxBCxEOoew+2gBt8m5y1nct1qABMhAw48102SSeF1LiepT4HJSm4KCYwiFfjRoVXGEcrcswiiCRsVmqneGREli1GmdufzIF73r7xhF3FB5SczUNHwXqrS32gt1DquEyZLZ2jhUG073RssiLsIxJWt2PIixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA0PR03MB5530.namprd03.prod.outlook.com (2603:10b6:806:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 13:26:41 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 13:26:41 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        David Lechner
	<dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Index:
 AQHcyDWKLXLdMUxvy0qzqrU5i7lMELXYzdoAgALtoICAAuQOgIAAD3yAgAEiJICAAEYbkIAADNdw
Date: Wed, 15 Apr 2026 13:26:41 +0000
Message-ID:
 <LV9PR03MB841487FBC424B52086B5F374F7222@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
 <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
 <20260412185821.739e477f@jic23-huawei>
 <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
 <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com> <ad9J9C5K7tyxuztU@nsa>
 <LV9PR03MB8414CFF38DAD2BEB7AE3E704F7222@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB8414CFF38DAD2BEB7AE3E704F7222@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA0PR03MB5530:EE_
x-ms-office365-filtering-correlation-id: e21b2432-9752-48e1-7039-08de9af2a155
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 HbZlGAucAnfwgvFT5JFGTjp5zgu1yNIUZVV/qFq3wRHMXZQjh+jrIf1nI4gbicZceyO6YgjkZVARVuREbHCk3pypOE+Zn0/SnIFVLB9sdKOZAwpFqHL7fqVQyeebnY9neYUnv5GpqXPGyiCw8A1rvBoSC+//PdbpoHBlQ2YzvX9md59dobsaXKfRNK0GVDPoKenUqZpF3kHVKv3mDTWwcgg6NOr9SL6lt2SheP8pXQs1teYVZ8mgz6k02mQWD2MCJpkEWixFbhsjDhad6DUwhnRnS+/Zma0Ua/CTBG3RKCYN2bXQwdgO5UmBJQiP5k/J38r/qMt9S/5IUtlT8qfFwbMjLxGGMikSJERvlTMPR29pKUT8Z8ByookQ/eOZcpmUMQffcU2smUaXASCbkWmFI3jL7mvBf9/OeGDUw5/tdo5q3HxetiyJ7jXjLJvA7MFN95X3KMF0XEWkcFo1ed1BeBdCHILpvAvAhNiBc1XFucH6UCxoNJFkMBdm0I4w0LpDNhlmfecNusbGHeqmVQqcaN/zbm9kDgA/jtyJM5YnlU69U2prfGFuGSq3mIPI4LtXXAk4bUuudXTvF9wKF2M+7TRjUc4y47xKpRmYjo6qlGq3hhfhIVNSM3u75e4fhrumQknwVR0gW5o12hFlk4ruRXWCyF119h0MlMIvQjh57jGjd6kkpc3eNOrDV3zBNpFLqbiTR0i6H1sEwFMYtmu3etDx/UVVpTPbY0HnFuzCWg5ATlVSH7zk9oBbua+oCMZy/JtcLqlMqrrGb/86+olKeMrUXnnYeb4Twvuful7oEe0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmcvUi80bzQzZVdoUEtrb2ZpbkJ4c0JkbHRCT2xLV0dHN0k5aVhhdk5RTkRv?=
 =?utf-8?B?RmVVTXFwTDNDVDZGVVZEOVVDQjBIYWkzczhpTE41bmpDMnVIQmk0citxYXpF?=
 =?utf-8?B?eHk4ejRQdG5nNHJpOHVra1BtTnQxK0tRNVdHS1Rqc0JsT1NXdmhQcUFra3FB?=
 =?utf-8?B?S3VVRTZlWDlWcWU4ZTlid3hkbVMxQ0tCVU1OdnNtV1lBRGUzQW1YVCtBZklh?=
 =?utf-8?B?cWRFQXlzd2R1TXZSUmxFZk1BRnJ2SEttZElZNVFmM2cwRjFRN3FKWUZOZGR3?=
 =?utf-8?B?VGU3K1ZSNmhaY0RVQWNaa0w3RloyNFIwbHllMFN1RjIxNkM3eFBUYlVvdGU0?=
 =?utf-8?B?WFo5K0htZ1Z2SEtBQTZDOUhnZlIvelZMK3N5eFRCWVdKZEtUOE9rVk0xN1Y2?=
 =?utf-8?B?TFNCWkpveUJzRE1qZVpncU1mNnEyV3dIejhwWmp6OXkvK2xkQzMyekE3QmFi?=
 =?utf-8?B?c2VJSURFTGZEb1diRCtYdGNkaDRJSDJkNERaSUlPb3QxcVlFL0JPZkFlQ1FN?=
 =?utf-8?B?emxzSWw5a09RNG85NFNWTVFXU1BOb3cvRW1KQ0U5eWVjMXNEcENCSFVMbzlr?=
 =?utf-8?B?RGxLWjdQazM5ZE8reVhSU1draW9mbHB3bVNyVHUxVWRKb2RBeWdWZXdRQkFZ?=
 =?utf-8?B?d1pvaHVBWm5PcndXM1lVTXgxYmlkb2FYb0xzSC9hb2ErdS9vTkpyWmI5MXh6?=
 =?utf-8?B?OEplSi9YeTVZWW1rR2lDY2xIZ1k1LzBMODMzTkNXN3JqYmpWbTcvWjcwRXlu?=
 =?utf-8?B?V0VuTW8wMXQxcy90Y2czYUQ0TTJUZjhGclZEaGtlL25VbHBndkJzenpHTFEr?=
 =?utf-8?B?QTJENVo0RWdHZ0Y2T0pXdi9xSGRNNzdMR1Z0cWFBdDVXWVljUldwVzdwZlhx?=
 =?utf-8?B?UndDQXJZMzNjRWFSKzFsVWJ0RGJQekdrai9EaERwdG9FRTBRbjJrcW5hOHhI?=
 =?utf-8?B?MHFUbEdGWXc2anQ5SkxSTzNyOVloMDZhY0QzenFoeEx5d2xQdDIvUDg4WFQy?=
 =?utf-8?B?ckVkdG5XRWRsTjdCanVVUlJ4NUtuc1psSzR6K081SnpPc09JTjV5NmtFRER6?=
 =?utf-8?B?REVuQkZmOWY2MnM4eVVWbWVYM0MybjlscFBsVWJjVlhUeWdOYlk1UXV5YnNq?=
 =?utf-8?B?WnZuTTZIWm80YjhvbmI5Rm5md25GQ09PRXpDeFhPYlpsWmVzZ0Z2NnN5Uk8r?=
 =?utf-8?B?TW5pSlJOQ2tlWDFFTGJTVzRtekVRV25JcjduNkZLSzljTDU2SDhBL0lMLzVa?=
 =?utf-8?B?MWlQQXdVdUs1QjlrYzJmYUZ1d0trdmwzTU1yeEJ2S3MwK25CUFBHQTNaa3dt?=
 =?utf-8?B?WGhNZ3FjOFdBYmxQR3FkWmNUTFlteERFQ2ZhTWk3UURaaWhObE9oSGliaEo4?=
 =?utf-8?B?VUIxOXZ0eXkvckJ5Uy84ZnA3MEN3cnFuZ2lOYWtHQUN6dFc1bVlzQkM2UWla?=
 =?utf-8?B?RzMxU1drWnZ6dzNnblpnL2tSNEN3UDN3bWtrcm1Pa2tkeXk3ZytHbXNnVy9U?=
 =?utf-8?B?cTM1MlFWRDNrTXpEWmFYb2lObnA3aXJ3RGhYTEc0QVU3cDd6Y1JuN05mNmgy?=
 =?utf-8?B?bFFjM0o0L2ZYVm1vU09iY2NJRS81TG1mSklwalVlSURSZWd6MEh5dE1SbzZk?=
 =?utf-8?B?dSt3UmFFOUtEc0hURmc1clBZY2hLZnkxK2ZFRlZMS2kxc0lkNkNXMnpxVW9m?=
 =?utf-8?B?aUFabkpwM2h4OGN1TmVwTWxEYTczcEFoeDcrNXRDa0c5UU5kRytTU3o0UVBi?=
 =?utf-8?B?cjkxQXkvbWhmQWJLN2dOakdIcmErNUJXc3lOak80d1B5SmhFdXJQMjhpazVs?=
 =?utf-8?B?WlZpQ2w3TEwwdC9FYVdib1dvdURBbHFNOGNJZG52RW16SWN0ZlUwMjZGN2ha?=
 =?utf-8?B?OTI4c0xqemN6THJzd0pheHhCVyt3TkRYTGZyWUdiL0ZCRnMzTjAxTU13RFQ2?=
 =?utf-8?B?WUx2dWJFL1dYWENPSHByNExmVy9DQ0VhZVpSUW55ZzFMWnlsQ3dRcjJPelAv?=
 =?utf-8?B?SkppZnhBazFVckxxSitPZGF5YXBPay96UzYwOW9adDV0czJEWnN0NTNLeGda?=
 =?utf-8?B?RmYyVEtycGNjdHVSbm5FT1MxbFBrRzJHNGdlUHVTcURlczJCVFJjTVBReU1U?=
 =?utf-8?B?akxTWE02aUg5cmZJNVdScHJ1Z2JWWVZNOVM5ZHlHbFo4ejZmOG5EakJEL1JY?=
 =?utf-8?B?S25zem52V3pRUmpzMDJGQ0FYUFhISFJncVBjdW5majUvZjFDWFVreTZmOG5D?=
 =?utf-8?B?aUZEcHk1RThWb0dYZnN0UUZqNCtVYWx4dldlTDdEdGxDY2l5d2pGVmNzaXRi?=
 =?utf-8?B?eERTYUFOVm9FdVphV2R6eHJrN0lTZlYzSjA1ZDNRS0MwZWhXNW5Bdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	S7Re4GWa87MGNeedi5oTqguZexvK3CA1Qj9nbYsRwXCCvJJvqQ5UtJOATO1BX0A2+SwtqR+niROy9tycOAcipVNJilGJB3+7KBVNBU6lPUpy3tpgd8GufaaEN952rzA9UThHWyrqqLMN128ELX9Gn8f010aeSErYRFJ54wegXoyr5wC12YQIH+7Ip83PSdiWBtm+WHvvq6zE3W+6XyZZEx84cLG3vg1C9kOXuyMrPVU1FgA3QPhsWPv1AL/H5JndCmiWCAM29AvF+gWIQeol5jyhJnc1hSLOUSpC+yrWe1JeCMVAvyaRKklJIASuxcpvutzYbLQyBEgC6Y1UGYxg2Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21b2432-9752-48e1-7039-08de9af2a155
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 13:26:41.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0R4jRoCviuZ9bB52MPo7RSmMsdzw4R1avozR4abXBGWIiWIKlEcgYPfPUUTaWvDbUDI+v/gEXqnt36Cbnin8yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5530
X-Proofpoint-GUID: ZDf06WNIbb13UFcyUUEDFxJtimTO9FGp
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=69df9214 cx=c_pps
 a=JYb6bdnaVjS17BdPGRuFtw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=87xyUlcm-9HoE0_PljkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNCBTYWx0ZWRfX7UZZZFURDfZS
 9ZCmrgtqdcnjY4ypxNcIhxbs1jdrqvnVgMt+T3xN2le6qKOxpxWdkseEYwiskgDWGY6ptdPgyba
 yttrho+p5ElPTVaYOtgfA6dj1maJRhittNb7+GswKs8aAgXqXItMymk9/UY8vUbWZKRfAKsUXtJ
 eVIa1/nFkC3hdvIA2oRNydZjFDJA+4QEONj27/X4IwhhS3nAn2pTyvnxuPd6/9kAiX/e0xz8rHq
 a2p8DoVPN3IDEMruDAC2kfHe5KsmmwVUQaHAOuUN+PeX1RQ+iitK9vmvIxtVY4FNxO+xv1si3rw
 Y4CnVY38ORt/Ave9twt/j9VEcdQ1XQ6RVkO4PWE5WvhvVhK8u/KI06v48aBlY7U/ILFxlRqXLnX
 y78KAoYD7NQ0p82VXCWXoKhcT1TdnTN8Ix8Q1uGFbLcfODbq3Le+YOBC4/QdnnwTbXjH1ctsvoM
 mlU6pkt2So3mqQH+0XA==
X-Proofpoint-ORIG-GUID: ZDf06WNIbb13UFcyUUEDFxJtimTO9FGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150124
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8587-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV9PR03MB8414.namprd03.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,metafoo.de,analog.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C7D1404C54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FiYXUsIFJhZHUgYm9n
ZGFuDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTUsIDIwMjYgNDowMyBQTQ0KDQouLi4NCiAN
Cj4gPiA+ID4NCj4gPiA+ID4gTW9yZSB0aGFuIHRoaXMsIGlmIHRoZSBPU1IgaXMgMzIgdGhlIG1h
eGltdW0gZWZmZWN0aXZlIHJhdGUgd291bGQgYmUNCj4gPiAzMTI1MCwgc28gMjVrSHoNCj4gPiA+
ID4gd291bGQgbWFrZSBpdCB0aGUgY2xvc2VzIGF2YWlsYWJsZSBvbmUuIElmIHRoZSB1c2VyIHdv
dWxkIHNlbGVjdCAxTUh6DQo+IGZyb20NCj4gPiB0aGUgYXZhaWxhYmxlDQo+ID4gPiA+IGxpc3Qg
aXQgd291bGQgYmUgd2VpcmQgSSB3b3VsZCBzYXkuIFNvIHBlcmhhcHMgYSBzb2x1dGlvbiBmb3Ig
dGhpcyBpcyB0bw0KPiBkaXNwbGF5DQo+ID4gdGhlIGF2YWlsIGxpc3QNCj4gPiA+ID4gZGVwZW5k
aW5nIG9uIHRoZSBzZXQgT1NSIHZhbHVlLg0KPiA+ID4NCj4gPiA+IFllcywgdGhlIGF2YWlsYWJs
ZSBsaXN0IHNob3VsZCByZWZsZWN0IHRoZSBjdXJyZW50IHN0YXRlIG9mIGFueSBvdGhlciBhdHRy
aWJ1dGVzDQo+ID4gPiB0aGF0IGFmZmVjdCBpdC4NCj4gPg0KPiA+IElNTywgdGhlIGFib3ZlIG1h
a2VzIHRvdGFsIHNlbnNlIHRvIG1lLg0KPiA+DQo+ID4gLSBOdW5vIFPDoQ0KPiA+DQo+IA0KPiBI
aSBldmVyeW9uZSBhbmQgdGhhbmsgeW91IHNvIG11Y2ggZm9yIHlvdXIgZmVlZGJhY2shDQo+IA0K
PiBBZnRlciB0aGlua2luZyB0aGlzIHRocm91Z2ggY2FyZWZ1bGx5IGFuZCB0ZXN0aW5nIG9uIGhh
cmR3YXJlIChhZDQ2OTIpLCBoZXJlIGlzDQo+IHRoZSBkZXNpZ24gSSBoYXZlIGluIG1pbmQ6DQo+
IA0KPiBpbl92b2x0YWdlTl9zYW1wbGluZ19mcmVxdWVuY3kgPSBlZmZlY3RpdmUgcmF0ZSA9IGBv
c2NfZnJlcSAvIG9zcltOXWA6DQo+IA0KPiBUaGUgY2hpcCBoYXMgYSBzaW5nbGUgaW50ZXJuYWwg
b3NjaWxsYXRvciBzaHJlZCBieSBhbGwgY2hhbm5lbHM7IGVhY2ggY2hhbm5lbA0KPiBpbmRlcGVu
ZGVudGx5IGFjY3VtdWxhdGluZyBvc2NbTl0gb3NjaWxsYXRvciBjeWNsZXMgYmVmb3JlIHByb2R1
Y2luZyBhIHJlc3VsdC4NCj4gDQo+IFdyaXRpbmcgaW5fdm9sdGFnZU5fc2FtcGxpbmdfZnJlcXVl
bmN5ID0gZnJlcToNCj4gDQo+IFRoZSBkcml2ZXIgY29tcHV0ZXMgdGhlIG5lZWRlZF9vc2MgPSBm
cmVxICogb3NyW05dIGFuZCBzbmFwcyBkb3duIHRvIHRoZQ0KPiBsYXJnZXN0DQo+IGF2YWlsYWJs
ZSBvc2NpbGxhdG9yIHRhYmxlIGVudHJ5IHNhdGlzZnlpbmcgYm90aCBgb3NjIDw9IG5lZWRlZF9v
c2NgIGFuZCBhbiBleGFjdA0KPiBkaXZpc2lvbiB0byBvc3IuIFRoZSBkaXZpc2liaWxpdHkgY29u
c3RyYWludCBlbnN1cmVzIHRoZSByZWFkLWJhY2sgaXMgYWx3YXlzIGFuDQo+IGV4YWN0DQo+IGlu
dGVnZXIuDQo+IFRoZSByZXN1bHQgaXMgc3RvcmVkIGluIGEgc2luZ2xlIHNoYXJlZCBgdGFyZ2V0
X29zY19mcmVxX0h6YCAtIHdyaXRpbmcgdGhlDQo+IGF0dHJpYnV0ZQ0KPiBmb3IgYW55IGNoYW5u
ZWwgY2hhbmdlcyB0aGUgc2hhcmVkIG9zY2lsbGF0b3IgYW5kIHRoZXJlZm9yZSB0aGUgcmVhZC1i
YWNrIG9mDQo+IGFsbA0KPiBvdGhlciBjaGFubmVscy4NCj4gDQo+IGluX3ZvbHRhZ2VOX3NhbXBs
aW5nX2ZyZXF1ZW5jeV9hdmFpbGFibGU6DQo+IA0KPiBDb21wdXRlZCBkeW5hbWljYWxseSBmcm9t
IHRoZSBjaGFubmVsJ3MgY3VycmVudCBPU1IuIFRoZSBsaXN0IG5hdHVyYWxseQ0KPiBiZWNvbWVz
DQo+IHNwYXJzZXIgYXMgT1NSIGluY3JlYXNlcywgY2FwcGluZyBhdCBgbWF4X3JhdGUgLyBvc3Jb
Tl1gIHdoaWNoIGlzIGV4YWN0bHkgdGhlDQo+IGNoaXAncw0KPiBiZWhhdmlvdXIsIGFuZCB0aGVy
ZWZvcmUgbW9yZSBpbnR1aXRpdmUgZm9yIHRoZSB1c2VyLg0KPiANCj4gT1NDX0ZSRVFfUkVHIHdy
aXRlIHRpbWluZzoNCj4gDQo+IGB0YXJnZXRfb3NjX2ZyZXFfSHpgIGlzIHdyaXR0ZW4gdG8gaGFy
ZHdhcmUgYXQgdHdvIHBvaW50czoNCj4gLSBTaW5nbGUtc2hvdCByZWFkOiBpbW1lZGlhdGVseSBi
ZWZvcmUgc3RhcnRpbmcgYWNjdW11bGF0aW9uLg0KPiAtIENOViBidXNydCBidWZmZXIgZW5hYmxl
OiBpbnNpZGUgZW50ZXJfY29udmVyc2lvbl9tb2RlLCBhZnRlciB0aGUgbWFudWFsDQo+IG1vZGUN
Cj4gZWFybHkgcmV0dXJuIChtYW51YWwgbW9kZSB1c2VzIFNQSSBDUyB0b2dnbGluZywgbm90IHRo
ZSBpbnRlcm5hbCBvc2NpbGxhdG9yLCBzbw0KPiB0aGUNCj4gd3JpdGUgaXMgc2tpcHBlZCB0aGVy
ZSkuDQo+IA0KPiBUaGlzIGtlZXBzIHRoZSBkZWZmZXJlZC13cml0ZSBiZW5lZml0IC0gYm90aCBz
YW1wbGluZ19mcmVxdWVuY3kgYW5kIG9zciBjYW4NCj4gYmUNCj4gc2V0IGluIGFueSBvcmRlciBi
ZWZvcmUgZW5hYmxpbmcgdGhlIGJ1ZmZlci9zaW5nbGUtc2hvdCByZWFkaW5nLg0KPiANCj4gQnVm
ZmVyIE1vZGU6DQo+IA0KPiBBZnRlciBkZXNpcmVkIHJhdGVzL29zciBhcmUgc2V0IGJ5IHRoZSB1
c2VyIGZvciBlYWNoIGNoYW5uZWwsIHJlYWRpbmcgYmFjayB0aGUNCj4gc2FtcGxpbmcNCj4gZnJl
cXVlbmN5IG9mIGVhY2ggY2hhbm5lbCBnaXZlcyBoaW0gdGhlIHRydWUgZWZmZWN0aXZlIHJhdGUg
Zm9yIGVhY2guIFRoZXJlZm9yZQ0KPiBoZSBjYW4gdXNlIHRoYXQgaW5mb3JtYXRpb24gaW4gb3Jk
ZXIgdG8gc2V0IHRoZSBidWZmZXIgc2FtcGxpbmcgZnJlcXVlbmN5DQo+IGFjY29yZGluZ2x5DQo+
IGFuZCBoZWxwaW5nIGhpbSB1c2UgdGhlIGNoaXAgd2l0aCBjb3JyZWN0IHN5bmNocm9uaXphdGlv
biBtb3JlIGludHVpdGl2ZWx5Lg0KPiANCj4gSSBoYXZlIGFsc28gcGVyZm9ybWVkIHRoZSBuZXh0
IHRlc3QgdXNpbmcgdGhlIGhhcmR3YXJlIGFuZCBnb3QgY29ycmVjdCByZXN1bHRzOg0KPiAtIHRl
c3QgY2FzZSAoYWQ0NjkyLCAxTUh6IG1heGltdW0gaW50ZXJuYWwgb3NjaWxsYXRvciByYXRlKToN
Cj4gDQo+IDEuIFNldCBjaGFubmVsIDAgT1NSPTMyLiBBdmFpbGFibGUgbGlzdDogezMxMjUwLCAx
NTYyNSwgMTI1MDAsIDYyNTAsIDMxMjV9Lg0KPiAgICAgV3JpdGUgc2FtcGxpbmdfZnJlcXVlbmN5
PTEwMDAwIChub3QgaW4gdGhlIGxpc3QpIC0+IHNuYXBzIHRvIDYyNTANCj4gKG9zYz0yMDAwMDBI
eikuDQo+ICAgICBDb3JyZWN0IHJlYWRiYWNrID0gNjI1MC4NCj4gMi4gU2V0IGNoYW5uZWwgMSBP
U1I9NC4gUmVhZCBjaGFubmVsIDEgc2FtcGxpbmcgZnJlcXVlbmN5IC0+IDUwMDAwDQo+ICg9MjAw
MDAwLzQpLg0KPiAgICAgU2hhcmVkIG9zY2lsbGF0b3IgY29ycmVjdGx5IHJlZmxlY3RlZCBhY3Jv
c3MgY2hhbm5lbHMuDQo+IDMuIENoYW5nZSBjaGFubmVsIDAgT1NSIGZyb20gMzIgdG8gOC4gRHJp
dmVyIHJlY29tcHV0ZXMgYXMgZm9sbG93cyA6IGVmZmVjdGl2ZQ0KPiBzdGF5cw0KPiAgICAgNjI1
MCBhcyBiZWZvcmUgYW5kIG5lZWRlZF9vc2MgYmVjb21lcyA1MDAwMCwgZXhhY3QgdGFibGUgaGl0
LiBSZWFkYmFjaw0KPiBjaGFubmVsIDA6DQo+ICAgICA2MjUwIChyYXRlIHByZXNlcnZlZCkuIFJl
YWRiYWNrIGNoYW5uZWwgMSAoT1NSPTQpOiAxMjUwMC4gKG9zY2lsbGF0b3INCj4gY2hhbmdlIHZp
c2libGUpLg0KPiAgICAgVGhlIHNhbXBsaW5nIGZvciBjaGFubmVsIDAgY2FuIGJlIG9mIGNvdXJz
ZSBzZXQgdG8gYW5vdGhlciBhdmFpbGFibGUgdmFsdWUgYXMNCj4gd2VsbCBhbmQNCj4gICAgIE1h
a2UgbWF0Y2ggd2l0aCB0aGUgaW5pdGlhbCByZXF1ZXN0ZWQgNTBrIG9mIGNoYW5uZWwgMS4gKGlu
IHRoaXMgY2FzZSwgc2V0DQo+IGNoYW5uZWwgMCB0bw0KPiAgICAgMjVrKS4NCj4gNC4gLUVJTlZB
TCByZWplY3Rpb24gaXMgYXRvbWljOiB3aXRoIE9TUj0xIGFuZCBTRj0xMjUwIGF0IHN0YXJ0IGZv
ciBsZXRzIHNheQ0KPiBjaGFubmVsIDAsIHdyaXRpbmcNCj4gICAgIE9TUj0zMiBpcyByZWplY3Rl
ZCBzaW5jZSB0aGUgbmVlZGVkX29zYz00MDAwMCwgd2hpY2ggaXMgbm90IGEgdGFibGUgZW50cnkN
Cj4gYW5kIGFsc28gaGFzIG5vDQo+ICAgICB0YWJsZSBlbnRyeSA8PSA0MDAwMCB0aGF0IGlzIGRp
dmlzaWJsZSBieSAzMikuIEJvdGggT1NSIGFuZCBTRiByZW1haW4NCj4gdW5jaGFuZ2VkLiBSYWlz
aW5nIFNGDQo+ICAgICB0byA1MDAwMDAgZmlyc3QgdGhlbiB3cml0aW5nIE9TUj0zMiBzdWNjZWVk
cyAtIG9zYyBzbmFwcyB0byAxMDAwMDAwLA0KPiByZWFkYmFjayBTRj0zMTI1MC4NCj4gDQo+ICAg
ICBJbiAoNCkgY2FzZSB3ZSBjb3VsZCBzdGlsbCBsZXQgdGhlIHVzZXIgaGF2ZSBpdHMgc2FtcGxp
bmcgZnJlcXVlbmN5IGFzIGlzDQo+ICgxMjUwLzMyPTM5LjA2MjUpLA0KPiAgICAgdGhvdWdoIGl0
IHdvbid0IHJlc3VsdCBpbiBhIHByZWNpc2UgdHJ1ZSBpbnRlZ2VyIHZhbHVlLCBidXQgYSByb3Vu
ZGVkICgzOSkNCj4gb25lLCBhbmQgd2hlbg0KPiAgICAgb3RoZXIgY2hhbm5lbCB3b3VsZCBoYXZl
IE9TUi9yYXRlIGNoYW5nZWQgaXQgd291bGQgaW1wbHkgYSBtZXNzeSBjaGFuZ2UNCj4gaW4gdGhl
IHByZXZpb3VzDQo+ICAgICBjaGFubmVsJ3MgU0YgYW5kIHJlcXVpcmluZyBhIG5vbi1leGlzdGVu
dC9tYXRjaGluZyBpbnRlcm5hbCBvc2MgdmFsdWUgKG1vc3QNCj4gb2YgdGhlIHRpbWVzDQo+ICAg
ICBhIGZsb2F0IG9uZSksIGFuZCB0cnVlIFNGIHdvdWxkIGJlIGxvc3QuDQo+IA0KPiBEbyB5b3Ug
Z3V5cyB0aGluayB0aGlzIGFwcHJvYWNoIHN1aXRzIHRoZSBiZXN0Pw0KPiANCj4gVGhhbmtzLA0K
PiBSYWR1DQoNCkhtbSwgcGVyaGFwcyBjaGFuZ2luZyB0aGUgaW50ZXJuYWwgb3NjIHZhbHVlIHdo
ZW4gY2hhbmdpbmcgT1NSIGlzIG5vdCBjb3JyZWN0Lg0KSWYgT1NSIGlzIGNoYW5nZWQsIG9ubHkg
dGhlIGVmZmVjdGl2ZSBTRiBvZiB0aGUgcmVzcGVjdGl2ZSBjaGFubmVsIHNob3VsZCBiZSBjaGFu
Z2VkDQpub3QgdGhlIHdob2xlIGludGVybmFsIG9zYyB2YWx1ZS4gVGhlIGVmZmVjdGl2ZSByYXRl
IHJlYWRiYWNrIHZhbHVlIHRoZW4gYmVjb21lcw0KdGFyZ2V0X29zY19mcmVxIC8gbmV3X29zciBh
dXRvbWF0aWNhbGx5IC0gbm8gb3NjaWxsYXRvciByZWNhbGN1bGF0aW9uIHVwb24gb3NyIHdyaXRl
LA0Kbm8gLUVJTlZBTC4NCg0KVGhlbiwgaWYgYWZ0ZXIgYW4gT1NSIGNoYW5nZSB0aGUgZWZmZWN0
aXZlIHJhdGUgaXMgbm90IG9uIHRoZSBhdmFpbGFibGUgbGlzdCAoYXMgdGhlIGVkZ2UNCmNhc2Ug
YmVmb3JlIG9mIDM5IHJvdW5kZWQpLCB3cml0aW5nIGBzYW1wbGluZ19mcmVxdWVuY3lgIChjaG9v
c2luZyBhIG5ldyBhdmFpbGFibGUgdmFsdWUpDQpmaXhlcyBpdC4gVGhlIDM5IHJvdW5kZWQgd291
bGQgc3RpbGwgd29yayBjb3JyZWN0bHksIG9ubHkgdGhhdCB0aGUgdmFsdWUgYXQgaGFuZCB3b3Vs
ZG4ndA0KYmUgcHJlY2lzZSB0byB0aGUgbGFzdCBkZWNpbWFsIHRob3VnaCBJIGd1ZXNzIHRoZSB1
c2VyIHNob3VsZCBiZSBhd2FyZSB0aGF0IDEyNTAvMzIgaXMNCm5vdCBhbiBhY3R1YWwgcm91bmQg
MzksIHJpZ2h0Pw0K

