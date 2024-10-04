Return-Path: <linux-pwm+bounces-3458-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F5990559
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E019B21589
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8672141D3;
	Fri,  4 Oct 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X92XIsgk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC602141B3;
	Fri,  4 Oct 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050897; cv=fail; b=LNMReGiDezF3SDl7J9nfDBjj6LiFlJRcOOFB3bEC1qKfokfBaHpW6WIySVOCTqRIfAFCkPj4SiKwY2O6OYrPsnmksfwZfGkvAINwkuDk53Os+ojIr/V2mQRGP7kfFu0E6UIhBEjsSjCNDXewKh3C4FpxHu0ZGa40xxDED4GLClw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050897; c=relaxed/simple;
	bh=Y21AaI+5tFJJVBsWLhHf54FVBfcTRYCKbOLfJfn2S7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/Ox4FV+KMGlLPLv2AtRK2lmJy3KyI7DMvHEcHnAIka3c/XuH6VyDdYmPKVOmE6nZgmC7C0CAwjADwD3fTWsxfah/TrnunmUJu94JBxm1mvrBlOAkqOboxtO2UqZmd3YzGjJUpJRv/7idT+Zce20vy2MQkOoQcIIFjv5LMOrCQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X92XIsgk; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494ClhNL018533;
	Fri, 4 Oct 2024 10:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y21Aa
	I+5tFJJVBsWLhHf54FVBfcTRYCKbOLfJfn2S7E=; b=X92XIsgkxNYUqwfNYROBB
	DXTpempp8XDRmqtTVsMlTDENPSXml0L0yd+Zp+xGNKhIiGDuIUsfhuIegeWglQjV
	nx3CZC9VJbIzdAq3Ghh3B0xOTOp0FU5Qp6dbrECsZFd4OvhwK8vk5+8BWE5MIpcX
	1voTZogs11OB5IoXnE4Jf681IObBigro8mnE7Xuprc3N0lMbQkVTh49srzTYoonh
	A2sVBJFUMi1QODAH0R6nA64nHS5sRPEkfgR0D76Jnr3tMDIIiNDjSrzeJHuHJUca
	6eFrZFQtSaBGgI3GaMinGnQEGfWzyj+xJWX6gpANro0OYpo/jasAcUheau8Vy9dv
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010006.outbound.protection.outlook.com [40.93.20.6])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 422043kwgg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:07:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUf1RkZyrDA83O8kgsUL9u/QYZiVAxB0aX5M1TC8fui58eQaoTqtjKahoXq9yx1MOpHrXr03x6Hx9MQwUdBG8Kvqs77VCjDQBGLxhOuvxQG3T4icJZM9cI9N+/4vF2qxb/HIdFt80sgrP1HcXYdJ8Pje/kueUyyoFv+aa+gNKuO8PgbJg9IqaCd+FgBgYlU1DJBZwiAsRNlLaZoZ1c+w55rfvwFVchQ2CTe9TfHELn0Bupq/o1G3FJJx+GGwbOLtgx0UsJR+YXvaxiOleFlLizzUwPeDnB+qgMMLLeZM8+3mgOs1CbXzK/WplAfYlfLc2ySYoRu2VOpKOzOHbAyMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y21AaI+5tFJJVBsWLhHf54FVBfcTRYCKbOLfJfn2S7E=;
 b=ttO0I2jxPuATlpkUQxDSio5v1tGT/ai1/kv9T+6+ztQN5VV1UFLP7w7EBhcg1CGb1KVtc+ElPS/goPRR0NZQL2ItkakIu0HoXp2rFsxOVRQmWP3vIYaOB7viRUSqygxDY1Q2bSvcd8CuqqoPyJchftuo5SaQ9OkGvZjIFfI/hfbh/1xS/5TbTB0o8dAtjYWmNTXwSwxD7s3x2O92uq5nJ/loy+Gz/Wf+5/jcM5McDuHyzQDxk0XkdAOvND1lSDlmoBNb4rYZEhUMy4FZRpMtFGQb+8lGFYp+YDnrJ7udKT6wvHwWhNdkCBqs8ulsgqmmxO7tASDAw4vJcSBig/J9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA0PR03MB5468.namprd03.prod.outlook.com (2603:10b6:806:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 14:07:38 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:07:37 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Thread-Topic: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Thread-Index:
 AQHbDaHI9TSlXyKXhk60pta64z5+prJtga0AgARN+RCAABcUgIAAD0aQgAAFf4CAAuGo4IAAMmKAgAGb4GA=
Date: Fri, 4 Oct 2024 14:07:37 +0000
Message-ID:
 <CY4PR03MB33996A380953651B290EC3839B722@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
 <CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
 <CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
 <42165d2b-1103-4316-841c-45514a626be7@baylibre.com>
In-Reply-To: <42165d2b-1103-4316-841c-45514a626be7@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB3TURnNU5XRTJNUzA0TWpWaExURXhaV1l0WVdaaVpDMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTURBNE9UVmhOakl0T0RJMVlTMHhN?=
 =?utf-8?B?V1ZtTFdGbVltUXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlOREV4SWlCMFBTSXhNek0zTWpVeU5EUTFOVE0xTkRJeU16QWlJR2c5SW5k?=
 =?utf-8?B?UFltUkRNamc0V1VGU2NtbE5iWGxMY0hCb01DOWpTVVJOUVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWxkMWFETkVXbWhpWWtGYWFUUkNRa1VyZEhWNlVt?=
 =?utf-8?B?MU1aMFZGVkRZeU4wNUZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmJXazNTbTFSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA0PR03MB5468:EE_
x-ms-office365-filtering-correlation-id: ed8c0d63-9b29-4bde-58cd-08dce47de704
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZW01QURITkdOV1V6eUJtRm1hWVp0TEtuRjdUY1JjaXdwc0dIUnoxdS83L3N0?=
 =?utf-8?B?T3VYWUlhTVFQL1JMaXlKZ3FLSVZYL2FEamo1cXo0TnBEeDNnY0VCVks2Z0dV?=
 =?utf-8?B?amVvWWl2NitoeGRKWkQ5Z0U1RlNEc2V3cDhzalY3NTJ4VnJsam4xUENmZzBr?=
 =?utf-8?B?dUxBMGxmUDl5VXp0dHcxOVBiUDNJZlA2dk54Z2ptZ1hXaEVKKzRoMC9BNzg4?=
 =?utf-8?B?TGxaUmtvYzZacFRjZkp2dDI3NjFTWXJzTGI1Rm5CWksvWkg1QW02bTN5MWF5?=
 =?utf-8?B?NTFpNDhrM3h5UGZaNkNDS0NURmcvY1U1cE9rRnhPbUNKR25iNktYYUxzMTMw?=
 =?utf-8?B?YnlaK2c0SnJLRXhZQ1kvQVE0SmtsT2ZlS1lMVTNYUWcrQm1IRnd1end5TjNn?=
 =?utf-8?B?bmxndWJidU5FOEg5MEVrbWRta2NKMHJlRng0T3Z1cHBsaC9ONzY1dFNCNDdl?=
 =?utf-8?B?UDVRWkw0Nkw0K3NWMUdEVEszcE9lS3FRTFB4ZU01ZEZKNGtsdU5GSm91MlZW?=
 =?utf-8?B?Y3NZSEVWQit4QjVwcmgxczlNaEY0dXJXT3cxY3ZBdHN0Y241endicWZucnRu?=
 =?utf-8?B?N2t6OHRXQ0dOanlSdE1rRnVvalkrK3pyKzkvNVRHR3hObXFjYWdhdUVyVENH?=
 =?utf-8?B?TGk3MmhBUjBEUnZUbEU5NjJUVzY2ZGZvcUMrYnZ2a0Q0QXQ2cVpQV004RGVk?=
 =?utf-8?B?UnBxVG5EK1o1cEdINVNmUmNKVVEvWG5JUXRWTDZUa2JmR2VTeXJBcjBIVHc2?=
 =?utf-8?B?S2pNWG5FdEJCMmU4SmVGWm95Nll6Z1N5dHZWR3B5YkhoV3diY0FnbjV5em1V?=
 =?utf-8?B?b1NvZWZLcTdqWHVjeDZvNXU2R0psTUo1OU13bjltdk9rWExkc3p4VldsWWM5?=
 =?utf-8?B?MHB6dnFyenBPMitRMzdOeHhtVDZzcXFNMjIyMFBMUGtvcFNiNDZCU2ZKSHRV?=
 =?utf-8?B?U20ySDRtbDVBYUVHc2hKQmkzMXA1cERNaG1DMkNoY2JZdkdIdWFPbjVVMEtP?=
 =?utf-8?B?TzdZSGNVTTU4ZEd3dzNOUnA5Y0pVckpsYjFBUXg5dGNYZWJDY2dpTG05dEgv?=
 =?utf-8?B?VmxpbzZKU3dicWR2MzUyM0R3c2tuUjk1ZUFOcUp1UElRWEN3am9YZFZncHFX?=
 =?utf-8?B?ZENYRTEvUXFJRDJPMHExci9Lc3ZiS3BVTGtKNUJkNWZheUtZb0VabHloVlVk?=
 =?utf-8?B?S3N0V3JrZWMzQnd3cFdKZklPcTFBcHNnUFV6QWhvdExEQlhhM0g0VHNBVCtR?=
 =?utf-8?B?SWJiSmRjSlJwNnJKZ3pkM041c0c2NVpvamRKYWJ5WW5vdHZCZHdMay9LTmFo?=
 =?utf-8?B?ZTNYQVo1UmZkUTZRSEJyNGhiQzVuNnhxMlZCUnVaUE4zT1JJZHRsUnEyWjZI?=
 =?utf-8?B?WEJ3K3ZjUEVEaWdQUG9YUnNwZVVIdTlrUnJ2ZWxSV1JDb3hIL3RWdy9lWHQ4?=
 =?utf-8?B?MzRPU1B4QUxIR25GbHpxNWllY3ljYVZ3ejRnSHNLVnQycmNpN3ptVzJ4bVJt?=
 =?utf-8?B?ZkpJR2Jtb3gvcFdoWEs0eWdCK25QUzFtWDNOUCt6YjdORjBFN0ptMDJoSlU1?=
 =?utf-8?B?Mks4d3REYjdMTllUSzBKcHlHZTJzRUoxQjZLcmQxVFNFeVYzd1dKNG9LTndn?=
 =?utf-8?B?SWlTSkV1Q1VxUG93ZGpIYk9xbGRaMEJCNEZaYnkweTZxU1ZIQWdmTWd4bDMy?=
 =?utf-8?B?TlQ1QndYQVJTTTRhTzNGKzJibzNDU3QvUGFlMmtzcWdvRVhtbW82ZnhUaER1?=
 =?utf-8?B?Wnl3bXR5cVk1VGVFQjRoeGNnOUU3RUJJVkU0WFliNzZLT0c3Y1VlbWRzVVJu?=
 =?utf-8?B?OHREMWlEMFJDQndKeFNLZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUd0VHJtRkFVVDJGWlc5SWF0MFlvdytOaG4xdTlUT2pOZ2UrRzIwQld4eWZ2?=
 =?utf-8?B?eGxkZHhRV0NJaWlPdkhLU1dJdEJtQ21DSy9BVzBkZjRiVEFob2J1RVQyOWxz?=
 =?utf-8?B?dGZtZ1RlWnppMnhYUndSK1dyaDVFNXNVNlR2b09DZXVmUWFYVnFlaTZqd0pC?=
 =?utf-8?B?Nm5Vd2F0UDRLcDZaV3o5YUtWbnNCcHMzWGxBbUlQcno4LzN0YkY4dWQzSEJD?=
 =?utf-8?B?WG9LUS9saEovMkk2K0xwM1JPQmtHWFVxZ0pndDl5K2JJRVVvcE8raTl1Sk9Q?=
 =?utf-8?B?Qi8rWW5WWmhvRWhLN0FITm52OEdHdU9kNmxkRnhTT3B1cm41NG1DemRZUmpB?=
 =?utf-8?B?KzFpVDRjYS90dXd0QjA5QTU0N1NBSGh0eVUyWTVsOWJKSFpPWFRxMEs2Y2M3?=
 =?utf-8?B?K2dDMHB5cXErSitEYUJBUm9ldGZrR1hFYlY2UXM0aXFlVDliSlVEdWZtV1I2?=
 =?utf-8?B?WDRYUDJqSkEwVDBMaWxiZEl1a055eGdjWTllb2xZSXVab21DaEM1T1ZKUUJY?=
 =?utf-8?B?V3h0N1dYbFBCT1pxQ1RWcHpYenplU3U0Sk9Kd0prYjU5Uy9QYXVHQnI3ckhJ?=
 =?utf-8?B?UVhUcUI2NkdyckZrU25xUzlkYmVtb3FNNUNzbU9UWUQ5dTgrMmU2dHNmQTlZ?=
 =?utf-8?B?eGxOZWlRYXRRYWtVdzVDRGZleWhRa2JBV285eDNqVm0wVnBUZW51UktycXVQ?=
 =?utf-8?B?a05PNnBHZWlVWmMwU0krZ05RcS9TWkVZUG40THpGSVdjbmhIL08vL2Y1bWFR?=
 =?utf-8?B?a3JxRFFMZDlRRDFQSjRrUTdkbk5NcVhQU0NxSVFiOVRaRVJmM1pxS2hNMm5s?=
 =?utf-8?B?bU9wWmRmMjlDUjZOVDJpRlZod0pObFJza1l1cDR6bVlwRGVRVHFLbkJqYXdF?=
 =?utf-8?B?VkNFWVJUQ2xLaGh1R0xjSlM1Q0ZuYWt2TG1GVGtjYXNFN0xHTERMYUJNTXE3?=
 =?utf-8?B?cjBZS1VSVjJIZm9xbVJMdm0rZFJPbTNUVGNvVVp1RkNkMDhkdkVGVkpISlN6?=
 =?utf-8?B?WmpyWFptdlc0K3pDVkVnVjV0ak1MNTlPNzFaWWY5R2NlUzFkcjNwSTlja1pv?=
 =?utf-8?B?L0JTeEJMbC9aU2docFp0ZTd2RnJlaThWZkhiWGI2ZlFwL3p0cExFYmhwZGdB?=
 =?utf-8?B?MnQ0N1hFT1hIc0hqVzh0c1RWcnNPbzFMVDcydWxaVFUyUHI4UXZ4aUlpV2lq?=
 =?utf-8?B?SC8yQzJGckZOQlBhYXdPcVBrdTRvazFDZ3l3OW9aWlRqNzBmSWl2MGpPOHJr?=
 =?utf-8?B?MElpN0M1eFkxTjMvamVZVm04RDd6TVZsSmxSVGF3VXkwNi91WitGTUZLWUVp?=
 =?utf-8?B?a0xZUmtJckFydjh6blJMcEpuVXBVZFMxMXZkS2hSY2hOMjEwZ1NUekVDNy9z?=
 =?utf-8?B?K0NraG5TbWh6b0RvOGVyZzBTbFJpaGNpMC8xZEdoa3NnN3VWdHhld09nNEF3?=
 =?utf-8?B?TCtsMkdnWlZ5aDZPTVV0YkdraE1oNkYwNWdCM1R4dTdlQTVBSFI5am94REsy?=
 =?utf-8?B?U3RoZ3A4Q3BvSERIU2Zxb3l5K3c0aFppcXliTVFSbDVVcEwwY1N3Y1VvOXZR?=
 =?utf-8?B?M2trZVhDOTRkdTVVTUd5c0NGaDh4YXQvZGN0SWFwVFRGOUIveWx0ZDRaZ2tk?=
 =?utf-8?B?WDZwMFhBWmhwLzRxa3pIRHlqQjZjWkZKL3hSVGhSbVZxM0w3N1FHd3gvQ0Fl?=
 =?utf-8?B?eDdLaVU3VGFNV09ZOWlDQjBHTkgvemlXUzNPNFhkaVRTL0I5WUM5N09DUmFw?=
 =?utf-8?B?TTIrSVBVbUpLajdHMG1WZitGei95WjcrTEhKU3hrQ3pEeElVMjdBNmxsYXk2?=
 =?utf-8?B?TnN1OEN4Vkk4OTByZ1VCaTcrVFd0SitNSnYxc3BFeWY1RW5mUVFqMHYyMHkz?=
 =?utf-8?B?dVZpMFFPdFF1Qy9PbmYzVmpVTzBRcmR6eXVNYlk3QW1FaFI4RktHNlBqYUdF?=
 =?utf-8?B?M053bzQ3dHRCcXd2SzdUN3NJNHpRUGFzcTlxUWJrb3h5aVBpaDFMdHl4ZXBw?=
 =?utf-8?B?cnp1VUU1YWoxc3NVTUFWWjZDMFMxZlE0L3FUb2ZtVU1Na0FHN0VGUW8wczBT?=
 =?utf-8?B?Mm1SRnljdVJkRk1oek14YUZaSDJaNTZaVFR3VUVuV2JjTUlubUdkK2M1MXFB?=
 =?utf-8?B?VE1mTVVhV1NScExPWEVMNmQxTUNpczV5NGJRU0JzNCtzeWRYb1VuaWpOc0po?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8c0d63-9b29-4bde-58cd-08dce47de704
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 14:07:37.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UElHXY2AfcSVD1vATN8xRyv6ak/K3RSExKT9jcXtxR6fE94yBn7Wjl+49SVpe6zm4jLmIut664087h6s2RBq1YMbEUVbsVTKhHm8HzNYj8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5468
X-Proofpoint-ORIG-GUID: J5jGhAi4_oTv_JBs4Y2KfJIf3Ji-TKJm
X-Proofpoint-GUID: J5jGhAi4_oTv_JBs4Y2KfJIf3Ji-TKJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040099

PiBPbiAxMC8zLzI0IDU6MTQgQU0sIE1pY2xhdXMsIEFudG9uaXUgd3JvdGU6DQo+ID4+IE9uIDEw
LzEvMjQgODo1MSBBTSwgTWljbGF1cywgQW50b25pdSB3cm90ZToNCj4gPj4+Pj4gUmVnYXJkaW5n
IHRoZSBidWxrIHdyaXRlcy9yZWFkcywgdGhlIG1zYi9taWQvbHNiIHJlZ2lzdGVycyBuZWVkIHRv
IGJlDQo+ID4+Pj4+IHJlYWQvd3JpdGUgaW4gYSBzcGVjaWZpYyBvcmRlciBhbmQgdGhlIGFkZHJl
c3NlcyBhcmUgbm90IGluY3JlbWVudGFsLA0KPiA+Pj4+DQo+ID4+Pj4gV2UgaGF2ZSBfbm9pbmMo
KSB2YXJpYW50cyBvZiByZWdtYXAgYWNjZXNzb3JzLg0KPiA+Pj4gW01pY2xhdXMsIEFudG9uaXVd
DQo+ID4+PiBJIHRoaW5rIF9ub2luYygpIGZ1bmN0aW9ucyByZWFkIGZyb20gdGhlIHNhbWUgcmVn
aXN0ZXIgYWRkcmVzcyBzbyBpdCBkb2Vzbid0DQo+ID4+PiBhcHBseS4NCj4gPj4+IEkgYW0gcmVh
ZGluZyB2YWx1ZXMgZnJvbSBtdWx0aXBsZSByZWdpc3RlciBhZGRyZXNzZXMgdGhhdCBhcmUgbm90
IHJlZ19hZGRyLA0KPiA+Pj4gcmVnX2FkZHIrMSwgcmVnX2FkZHIrMi4NCj4gPj4NCj4gPj4gSSdt
IGNvbmZ1c2VkIGJ5IHRoZSBzdGF0ZW1lbnQgdGhhdCB0aGUgcmVnaXN0ZXJzIGFyZSBub3QgaW5j
cmVtZW50YWwuDQo+ID4+DQo+ID4+IEZvciBleGFtcGxlLCB0aGlzIHBhdGNoIGRlZmluZXMuLi4N
Cj4gPj4NCj4gPj4gKyNkZWZpbmUgQUQ0ODVYX1JFR19DSFhfT0ZGU0VUX0xTQihjaCkNCj4gPj4g
CUFENDg1WF9SRUdfQ0hYX09GRlNFVChjaCkNCj4gPj4gKyNkZWZpbmUgQUQ0ODVYX1JFR19DSFhf
T0ZGU0VUX01JRChjaCkNCj4gPj4gCShBRDQ4NVhfUkVHX0NIWF9PRkZTRVRfTFNCKGNoKSArIDB4
MDEpDQo+ID4+ICsjZGVmaW5lIEFENDg1WF9SRUdfQ0hYX09GRlNFVF9NU0IoY2gpDQo+ID4+IAko
QUQ0ODVYX1JFR19DSFhfT0ZGU0VUX01JRChjaCkgKyAweDAxKQ0KPiA+Pg0KPiA+PiBUaGlzIGxv
b2tzIGV4YWN0bHkgbGlrZSByZWdfYWRkciwgcmVnX2FkZHIrMSwgcmVnX2FkZHIrMiB0byBtZS4N
Cj4gPiBZZXMgeW91IGFyZSByaWdodC4gQWx0aG91Z2ggSSB0ZXN0ZWQgd2l0aCBoYXJkd2FyZSBh
bmQgaXQgc2VlbXMgdGhhdCB0aGUNCj4gcmVnaXN0ZXJzDQo+ID4gYXJlIG5vdCBwcm9wZXJseSB3
cml0dGVuIHdoZW4gdXNpbmcgYnVsayBvcGVyYXRpb25zLiBNeSBndWVzcyBpcyB0aGF0DQo+IGhv
bGRpbmcgQ1MgbG93IGR1cmluZw0KPiA+IHRoZSBlbnRpcmUgdHJhbnNhY3Rpb24gbWlnaHQgYmUg
YSBwb3NzaWJsZSBpc3N1ZS4gQW55IHN1Z2dlc3Rpb25zIGFyZQ0KPiBhcHByZWNpYXRlZC4NCj4g
DQo+IElzIEFERFJfRElSIGluIFNQSV9DT05GSUdfQSBzZXQgdG8gdGhlIGNvcnJlY3QgdmFsdWUg
dG8gbWF0Y2ggaG93DQo+IHRoZSByZWdtYXAgaXMgY29uZmlndXJlZCBmb3IgYnVsayB3cml0ZXM/
DQo+IA0KPiBJIGhhZCB0byBzZXQgdGhpcyBiaXQgZm9yIEFENDY5NSB3aGljaCBoYXMgYSBzaW1p
bGFyIHJlZ2lzdGVyIG1hcA0KPiAoYWx0aG91Z2ggb24gdGhhdCBvbmUgSSB1c2VkIHR3byByZWdt
YXBzLCBhbiA4LWJpdCBvbmUgYW5kIGEgMTYtYml0DQo+IG9uZSwgaW5zdGVhZCBvZiBkb2luZyBi
dWxrIG9wZXJhdGlvbnMgb24gdGhlIDgtYml0IG9uZSkuDQo+IA0KVGhhbmtzIGZvciB0aGUgaW5w
dXQhIEkgdHJpZWQgeW91ciBzdWdnZXN0ZWQgYXBwcm9hY2g6IHNldCB0aGUgQUREUl9ESVINCnRv
IDEgZHVyaW5nIHByb2JlLiBVbmZvcnR1bmF0ZWx5LCB0aGlzIGRpZCBub3QgZml4IHRoZSBpc3N1
ZS4gSSBhbSBzdGlsbCBub3QgYWJsZQ0KdG8gcGVyZm9ybSBidWxrIHdyaXRlcyBwcm9wZXJseSB0
byB0aGUgZGV2aWNlLg0KDQpGb3Igbm93IEkgd2lsbCBrZWVwIHRoZSBvbmx5IHdvcmtpbmcgdmVy
c2lvbiBpbiB2Miwgc2luY2UgdGhlcmUgd2lsbCBiZQ0KbW9zdCBwcm9iYWJseSAgb3RoZXIgaXRl
cmF0aW9ucyBvZiB0aGUgdGhpcyBwYXRjaCBzZXJpZXMg8J+Yii4NCg0KPiA+DQo+ID4+Pg0KPiA+
Pj4+PiBzbyBJIGFtIG5vdCBzdXJlIGhvdyB0aGUgYnVsayBmdW5jdGlvbnMgZml0LiBPbiB0aGlz
IG1hdHRlciwgd2Ugd2lsbCBuZWVkDQo+ID4+Pj4+IHVuc2lnbmVkIGludCAobm90IHU4KSB0byBz
dG9yZSB0aGUgdmFsdWVzIHJlYWQgdmlhIHJlZ21hcF9yZWFkLCBhbmQgaW4NCj4gdGhpcw0KPiA+
Pj4+PiBjYXNlIHdlIHdpbGwgbmVlZCBleHRyYSBjYXN0cyBhbmQgYXNzaWdubWVudHMgdG8gdXNl
IGdldF91bmFsaWduZWQuDQo+ID4+Pj4NCj4gPj4+PiAtLQ0KPiA+Pj4+IFdpdGggQmVzdCBSZWdh
cmRzLA0KPiA+Pj4+IEFuZHkgU2hldmNoZW5rbw0KPiA+Pj4+DQo+ID4+Pg0KPiA+DQoNCg==

