Return-Path: <linux-pwm+bounces-8834-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADdvJ5d+/GnXQgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8834-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 13:59:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2DE4E7DF7
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C58AD3009023
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06973EC2E3;
	Thu,  7 May 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dZLrGfFl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140483AA4E2;
	Thu,  7 May 2026 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155045; cv=fail; b=DthD1NuiM/8E+rpaDEcC9HYYYN+Khm3Xe5Ri5PuDWTsV668/WXOnpoILz2jPQcVBkttjRLN3l0Aae/02G69tLfPcLYJAeMAlQAsX71rDkLHMPFB9M05eprroyhjgCjaAs9G9pS+6MCMi11dckt5kprSej/9CBmnYfLx8Eqm05GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155045; c=relaxed/simple;
	bh=NZbHdll0zeWdmJmj102zpJvCTrL9EohTOPH4IZxShUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peJg0gtGQwCxQrxqTzdvx8eXcdpLBKQYqz+sR6k4e4wLZJeQ4k+NXJ9q7AyzGCAm3187Viw8RJ4Wk1jMk0RU3e/qjsPDR8/wYRcpBHj8bw2mKqa1de/s/1ZXIEf/I24WjanLLMPrC2RKFeeo65WrKcHTmbXXJ/zaoRvWlN9S0U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dZLrGfFl; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Ak7T6494381;
	Thu, 7 May 2026 07:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NZbHd
	ll0zeWdmJmj102zpJvCTrL9EohTOPH4IZxShUQ=; b=dZLrGfFl3OySmkBFgxpwT
	lU2GkobjmO2QFnYVqzRI/cU8w95XJDOrmslrrpclZIG1lWX06idpfs/RiBNMZ+Ow
	Hr3ZyfrpkaYAWNoDbmeZ9YsnE6G7k8SZZkoSZUF5SmCjbh+Qv8Z7JH7uk6lI8Q2D
	qPQTn9KDTEvo3/nx47jVy40UKV4P2D2JdkNPmosyMDPohvJMr62d9a5NoGCX3/FR
	+pt+ZLomCLPvd0XpQqLdZYpPmC3/kJG4MJDUZMmDTqiWXc5Q42ZIwHMC2T+9qgA1
	+NgQkW1KJlSv6k797/ixn4WwHDR+/ttevCnAKB7dRDqJv/BSfH4dkMDJe6wNAZHf
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dycmx27ep-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 07:57:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFQTstT4YywNBGMseE7tiH8aUpTTe0VGZhhaFLozi6pgNCAWe/tuNOGJbqu/5Dl6FDguWjT+1mYbl1keH//eRne33561dlSYxA+kPX8JxOXXtWehZp39+zD/wR+Z0edFKodx9TGGJADHMho8hORtkzVmQ3ICPOZE9QB2lfm1EVCc4AllDmHkO6Tr93ygJdGWi8Ei2+hpwmWTW9DwCUu3jr1QUTdZVp4eAwvXk0yBWoAnGl5L2r2d+oq98W/Eq8tQWlqX+OK6mhZTFzOElzU3gcqB4IKBmyzLGdRLGn3Fh+V16nPqbhwsoEIE4JA1l8XAXBjiHpR3WYoC345CIMuKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZbHdll0zeWdmJmj102zpJvCTrL9EohTOPH4IZxShUQ=;
 b=SFxwTcVYYYlSfE/ID+V85RFaUMEASyI+VTQ+2k7GtFjgjxErduL/Pbw4nhOFcW2WwQQ5rNmkcAAxK7gDWs/AadHSBZplKANgXz7MCZtKWjHMrbMZTqx3lzR+oFKieiND/uw7MoOWpWPE01VXKY7m1NJ1ZzHRGXpx2T7IhFHgK5JbqHLLVyaQ0JGQKw4sUSAYugZnwIJSROyTkE4Q1TGL75ZZzHNR0tqSIXiDcYJRSfZavoUTE1TohrpS5ZmOVGWcor+t/xo+NMO8YPc7hptNsAB2bBaC4EMcc469sKv1GxNIGEvXKCvzVTRzCKxD5HKS9XEguskPfYzqrrDQmdXZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA1PR03MB6483.namprd03.prod.outlook.com (2603:10b6:806:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 11:56:55 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:56:53 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
        Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v9 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v9 5/6] iio: adc: ad4691: add oversampling support
Thread-Index: AQHc2Ip8kQmY8V5CoESEKDg6S1Zg97YCfhmA
Date: Thu, 7 May 2026 11:56:53 +0000
Message-ID:
 <LV9PR03MB8414B9A4A4D48BDF8E60398FF73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
In-Reply-To:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA1PR03MB6483:EE_
x-ms-office365-filtering-correlation-id: 9c61bd88-c6c4-447a-09f9-08deac2fbb25
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|3023799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 aFuv+S3UzL9F0KllxaHQBWGxXsaREjXV5lbetNChd4/MQ80Y2wTFwq7cZgGXV4QJxzZMyPvmXZ6IXhFnmVFetzr5igijAZoJlVEKI/vrefQlYBeJQ3EHh25tm7BT3xMhkfqEP32cMuhsratYycv2xuiaeCLF//Fei6sHMO2RmPEV6QR7GuKyuf+mnEiPgLhRHLO8TbL0KWHgzL3dLyon9EJ1tXVKJAvOK7LW4a1SYhbHv8TAiCBeZrTPBcEEiC7rjb+lJDAx4V0+pPlJeSM3TRPunpKzvsxSuREXkxHN95cKdbYC3nMYS02cJ5K+vuk19jBCZVr5Yq2m9DI17d5suCFHf8+cr81dfrmC1s0O4DZ+5NsW+6cKHbPOSehQmFr5cf7DzpQXPFVekWDCNYhZ/89Vf4oMERUKi1nL8rmZm3ehUoxOV5mdeCltKaZnt7ExzkQ4TeRDclYmXhGTJP9qkcjucDuIutgAyvvDwH/iI47TZ4qRU62ZLs2eR4APHm7fCNlgmZ2n055u09+KE6e3Ka9SJok6wLm4W6Rxl7v8QvhenrqE6INR+NzgWbEV/HN5wyej2HQw2UKxgM0OVSKcwaKYRFZDwVj2QoKjCUI8AVdtBG5XRhXnV0hWvNTcd9aO7jcP4r3oDax6VO/O/uwCvreC6U4vWyp2CwQFvyN7a+e2aR82uwhX8jj2bcyhXX8YYqU2k06/YH7crOgeRJYZrmX6tfL+LWs7aDMYUluzcMoc7KZPr1efSN7/uYpDe9pgZtyxEwEQLjsGW3jewoEzpw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFFOdDI4Qk1uOHluR3kzZFhUMDF4UW5yK242L09wUkl2MStvYnpJc2ZKd2RM?=
 =?utf-8?B?UWNiYnpTSE91V2hnbkp1RTNhMWpwR0lFVFpLNHdBVU94bllDUzIrNldPYUY5?=
 =?utf-8?B?ZE9RUlpaTVpkN2ZERmFLWTMwVHNpejlCQ29WeFpiSVJMV0JWenl2bVVQVVVY?=
 =?utf-8?B?UmU5VFcreTkxd0ZUSnVDS0pFU1E3RERacmp0N28xWUdzQU1CWjF1bFVLRjdU?=
 =?utf-8?B?NElTN3hmN3NvdzV6eStSUlJKakgwSlEvR3dVSExYUC9Xa1JIV25jWEFTZndD?=
 =?utf-8?B?WlRjc0JTb1RQSVBWbC9CdDBka05NNkIvMzFkY0VmaEVhOVpnU0VuMm1OQXJT?=
 =?utf-8?B?MmtqWThSdGptK0NMSURzL2JmV0J6VmJTZEVnNnBySXFyalBYRFErV0RKRlJH?=
 =?utf-8?B?N2x2U2lNZ0hSazBlMDdIOWNZOW9lbFVrMEh5dzRROGk2SFhGMkFBZitMV3Nj?=
 =?utf-8?B?RXJqTzlFSUlEZ1hWVjk2SUN3MlNkUkFad2NjcWUwaExFeHJBQ2hqVlNTRThT?=
 =?utf-8?B?dzdqeHp6QVNIenBqS2xBRkt6ek9QbjEycnJtVTVDNXdUTEJ5WFRPQnFaVEcz?=
 =?utf-8?B?TDRiaU5NQTFuMG4xUGxXWkNjQjE1S3dVaSszM0hSRnNxTG5mYXdKclZWUUtZ?=
 =?utf-8?B?eFJpcklxbi9rbUtqQ3RRTEVkaFp6OWJoSmpLcFZoY1ZvN1RYemxUR09HNnNi?=
 =?utf-8?B?dTZlaTBlZUY0bnNrNHNwME1TVG0zbXZVUHFUelJYR2lpVU4wdnB3ZGE0T2tp?=
 =?utf-8?B?d20rWnFEQkJHdGk2R1VLYmpLeHp1UWd6cmFYZDk0MVhqUTkxT1psa1dNcVVF?=
 =?utf-8?B?dWZBdUxFSCtnTmlvMWZ3aTVDK0VOVzVpNjdPTnJUOThRMGVueENGYlpRQVl6?=
 =?utf-8?B?eHhERkZ2L0dMUDZDOW1sQUo2VWVQQUNCaE5zS2E4d05ocHpDdDE5ZWVsVXll?=
 =?utf-8?B?eEUzVUxNK25ncGxrb3Y5ZDBRQnVvK2lyYlRrZmExZWlSOVVsQWdTaHJmSEtO?=
 =?utf-8?B?a0pUUk1XelBMUlBTeGtNZkJQRkxSZDhQL2I1K0g4VkUvNURLak1CdmczVTNI?=
 =?utf-8?B?UWpZVndsdWFtNkRrSmJISnEweTRtVTFCOVNub2R3R2d1SjlrTTZUVlBJSmZ5?=
 =?utf-8?B?emxYazhDUGM2dFFlK1RJTTFNUGdIaW9MVXc2TXg3dkVNcVZheUVOajNOUDFz?=
 =?utf-8?B?a3RrNkRMN0E1QW1zMmlFVVBKanRGSjRGbENZZVBndjI1Zm9vNG1WL0Q0THd5?=
 =?utf-8?B?REYxaG1wQ3Y1SHlEd3ZLeUVLMXlVMmhUVnAva1M5YmVnRUluSGlocS9scmpJ?=
 =?utf-8?B?MEdHWEh2R3FkYmFMRTFQVmhBUlRwb0lEK05ERG13OXFMRzRKeUQyUGhFN2RC?=
 =?utf-8?B?YWM1WU5EeDRBdTFac2ZkTEs5SE4rZGJva1A3WHJhUjMvY0R6d3J3L0NXcWlj?=
 =?utf-8?B?WXZJM3dvS1djR0FFSnpSdGlhMXVOdE1ieTQ3dEUvU1hFazNaSVVES2hFUUFC?=
 =?utf-8?B?dVJEdU1WN1lodnFaRE92UWVpUmgyaE9iMHRSVnI3S2Q3NlBBRjljMFNNaHVh?=
 =?utf-8?B?NXBGVmFkdnVFK3BwWGlqUlVuTU1HNnh3TVlTQm9tN1ZiM0QzS0l2UWxGWGJo?=
 =?utf-8?B?WnBtOVNObUNKL3hhKzhHcHpyeU55dzh2ZUx5R3JSc25LOE55WE83TVBSamhy?=
 =?utf-8?B?VENmSG5GcGpzd1FJYms1UTBCNE93TG1BdExNVkNiUHlRRk0xS3FhNndyWVJW?=
 =?utf-8?B?YVhzVkI4REkydjkwUUtqZkpUVFF2Y0t2SHNjM1E3R3ZGMjVjcEZFdlFwdmJw?=
 =?utf-8?B?bTNkcmRGY0EwQnMxeUh3WnYxYk9HYlRROTVPWHF2alhuZzc4eVFZc2RQdEZB?=
 =?utf-8?B?OEdFdndQR3dCQWZmbjBkQUhYOTRUV3hFOUkvRFRHVXYxWi9VQk5IaTE1bkZ4?=
 =?utf-8?B?WEU3MUh4d2FmSFBoTWphK0k4MG5tMWhVK25qK3BTSllkMTQyRTJhZDB2TFVY?=
 =?utf-8?B?eldkL0gwS0E0ajRzV2Fob3podmNwYTUxWWszR2Z3REVtUTNjK2FFOTFhcU5Q?=
 =?utf-8?B?MFg4UEVXd3BwWTlnbDZXRGZpQmhlaUU3RWNiVW9mRS9PdnJkbEZiY2NFTmhq?=
 =?utf-8?B?Y3htL3h0K2QzSXJEdU1lK3plSGVJcU1HSkZ3Q0pzK0M2VVd0SVBNdUtVOFhX?=
 =?utf-8?B?TVd6RXRHbCtnSU5wUCtEKzQ0MnhQclVrMk12QUl2cFhmSGhXdDhwNDVadVdB?=
 =?utf-8?B?QXM5OWRPZW40RHdVdDQvTXZGM1dBbi96QXk1R3Y2cnN3TFJOM3dvbW5qc1E2?=
 =?utf-8?B?dm82M2c1RjRPYXRsRWxkZFYvenp4RFZibDlYdTRkV0tKOHdUNFpTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bsC8lBMFDEr4lfcYumG8Zp2ho9BRz9XMmmEah1EXrT4n/JPllOPFwZ0Wv6VSaJExHewToAGmiufNQdEAZnl1vkmg1WZxqRkwfdjhkFMfCx4bdbN6ZIsBUtpz9/9Vds3EhPBCMCACJ13c/9Ize1hKil3Ygh4mfBCPnN5+iUJDb/xhTnM2jnfn+R+LnJW4uukpoAOIjflsD/lDrccEiAsZPx+Ok2ZnIj/F6bDEK0XW+iO8IedF6bvL1l5QUCJSIvlJ3IhAgxAoU1qauzDOXNPdc/NQnDzfJmbGztG9yydd3VdMdQ/Dp0kkznbXtOX8rhWsjIgxGcht/1FwRyPmO/5Lfg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c61bd88-c6c4-447a-09f9-08deac2fbb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 11:56:53.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzemjhFL4BJv96tHGrfvOsavkdu0E8XBlowe2x24U91L3iIjJUyegT3AidpQkbqRfPeKRyUPMNXJbNhfKsOnvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6483
X-Proofpoint-GUID: 3WA8U1JLZqqy2DhVLHFVYCrIsCGHY1Cn
X-Authority-Analysis: v=2.4 cv=C6/ZDwP+ c=1 sm=1 tr=0 ts=69fc7e0d cx=c_pps
 a=5LsHMtEjVXEroYtotTqlkA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=HafNp-7GGZKF1gJ5sP0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExOCBTYWx0ZWRfX4uKYH7x998rv
 BGg9FeBWnluKKB7oPMZK7tvZe45A7tjwUuUAJl43xhosn8nstPwfmlQYrZKyyQ1CNk6d/++XCSW
 oh+e0ZkRrJCnEPj+bi7VAYkbH8CdsFadgP7blo/PwQTq5DgUjxqGqm2CRU2XVJas8rU3JZDqBUM
 2DPz4K5Sm9T2oTYBne1pdNgXi8z9yhxM9hXuRV5YJecKFq6IfQXeY7+Yy0WSXos6zoF7utBrvMq
 CcEOttacCq5ZV2NHvzkWVzRjv58WFHw8y1fSBhj6rqxb4pf+S29HuRW5rVKpbV3Q0eyec4i2eWJ
 w1jgBOB5LQRrbV70v6EzS6jeIQogwN3Agt/V+muOie78XXQqXl+kmwm3GSYIVkDV2cXLKHDRS/h
 4Ig2bsP1w1BU7q8GrdFvF1x4sQdt+SSz1ae5GYmA0pTDwwRYBr4e0ulpNg+TQArcF8Z413Z3jxJ
 I78IZdydFuHDS7UuZAQ==
X-Proofpoint-ORIG-GUID: 3WA8U1JLZqqy2DhVLHFVYCrIsCGHY1Cn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070118
X-Rspamd-Queue-Id: 1B2DE4E7DF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-8834-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:dkim,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

QWRkcmVzc2luZyBTYXNoaWtvJ3MgcmV2aWV3IGZvciB0aGUgb3ZlcnNhbXBsaW5nIHN1cHBvcnQg
cGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFkdSBTYWJh
dSB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmFkdS5zYWJhdS5hbmFsb2cuY29tQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyNiAxOjE3IFBNDQoNCi4uLg0KDQo+ICsv
KiBDTlYgYnVyc3QgbW9kZSBjaGFubmVsIOKAlCBleHBvc2VzIG92ZXJzYW1wbGluZyByYXRpby4g
Ki8NCj4gICNkZWZpbmUgQUQ0NjkxX0NIQU5ORUwoY2gpDQo+IAlcDQo+ICsJewkJCQkJCQkJXA0K
PiArCQkudHlwZSA9IElJT19WT0xUQUdFLAkJCQkJXA0KPiArCQkuaW5kZXhlZCA9IDEsCQkJCQkJ
XA0KPiArCQkuaW5mb19tYXNrX3NlcGFyYXRlID0gQklUKElJT19DSEFOX0lORk9fUkFXKSB8DQo+
IAlcDQo+ICsNCj4gQklUKElJT19DSEFOX0lORk9fT1ZFUlNBTVBMSU5HX1JBVElPKSB8IFwNCj4g
KwkJCQkgICAgICBCSVQoSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEpLAlcDQo+ICsJCS5pbmZvX21h
c2tfc2VwYXJhdGVfYXZhaWxhYmxlID0NCj4gCVwNCj4gKw0KPiBCSVQoSUlPX0NIQU5fSU5GT19P
VkVSU0FNUExJTkdfUkFUSU8pIHwgXA0KPiArCQkJCSAgICAgIEJJVChJSU9fQ0hBTl9JTkZPX1NB
TVBfRlJFUSksCVwNCg0KIlRoZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSBhdHRyaWJ1dGUgaXMg
ZXhwb3J0ZWQgd2l0aCBpbmZvX21hc2tfc2VwYXJhdGUsDQppbXBseWluZyBwZXItY2hhbm5lbCBp
bmRlcGVuZGVuY2UuIEhvd2V2ZXIsIHdyaXRpbmcgdG8gc2FtcGxpbmdfZnJlcXVlbmN5DQp1cGRh
dGVzIHN0LT50YXJnZXRfb3NjX2ZyZXFfSHosIGEgZ2xvYmFsIHZhcmlhYmxlIHNoYXJlZCBieSBh
bGwgY2hhbm5lbHMuDQpEb2VzIG1vZGlmeWluZyB0aGlzIGdsb2JhbCB2YXJpYWJsZSBvbiBvbmUg
Y2hhbm5lbCBzaWxlbnRseSBhbHRlciB0aGUNCmVmZmVjdGl2ZSBzYW1wbGluZyByYXRlIG9mIGFs
bCBvdGhlciBjaGFubmVscz8gU2hvdWxkIHRoaXMgdXNlDQppbmZvX21hc2tfc2hhcmVkX2J5X2Fs
bCB0byBjb21wbHkgd2l0aCB0aGUgSUlPIEFCST8iDQoNCmluZm9fbWFza19zZXBhcmF0ZSBpcyBp
bnRlbnRpb25hbCBoZXJlLiBUaGUgb3NjaWxsYXRvciBpcyBzaGFyZWQsIGJ1dA0KdGhlIGVmZmVj
dGl2ZSBvdXRwdXQgcmF0ZSBpcyBnZW51aW5lbHkgcGVyLWNoYW5uZWw6IG9zY19mcmVxIC8gb3Ny
W05dLg0KV3JpdGluZyBpbl92b2x0YWdlTl9zYW1wbGluZ19mcmVxdWVuY3kgc2V0cyB0aGUgb3Nj
aWxsYXRvciAod2hpY2ggY2hhbmdlcw0KdGhlIHJlYWQtYmFjayBmb3IgYWxsIGNoYW5uZWxzKSwg
YnV0IHJlYWRpbmcgaXQgYmFjayBmb3IgYW55IGNoYW5uZWwgYWx3YXlzDQpyZXR1cm5zIG9zY19m
cmVxIC8gb3NyW05dIOKAlCBhIHZhbHVlIHNwZWNpZmljIHRvIHRoYXQgY2hhbm5lbCdzIE9TUi4g
VGhlDQpvc2NpbGxhdG9yIHNuYXBzIHRvIHRoZSBsYXJnZXN0IHRhYmxlIGVudHJ5IDw9IGZyZXEg
KiBvc3JbTl0gdGhhdCBpcyBldmVubHkNCmRpdmlzaWJsZSBieSBvc3JbTl0sIHNvIHRoZSByZWFk
LWJhY2sgaXMgYWx3YXlzIGFuIGludGVnZXIgZm9yIHRoZSBjaGFubmVsDQp0aGF0IGRyb3ZlIHRo
ZSB3cml0ZS4gVGhlIHNhbWUgdHJhZGUtb2ZmIGlzIHByZXNlbnQgaW4gYWQ0Njk1Lg0KaW5mb19t
YXNrX3NlcGFyYXRlIGlzIHRoZSBjb3JyZWN0IGFubm90YXRpb24gZm9yIHRoaXMgcGVyLWNoYW5u
ZWwgdmlldy4NCg0KPiArCQkuaW5mb19tYXNrX3NoYXJlZF9ieV9hbGwgPSBCSVQoSUlPX0NIQU5f
SU5GT19TQ0FMRSksDQo+IAlcDQo+ICsJCS5jaGFubmVsID0gY2gsCQkJCQkJXA0KPiArCQkuc2Nh
bl9pbmRleCA9IGNoLAkJCQkJXA0KPiArCQkuc2Nhbl90eXBlID0gewkJCQkJCVwNCj4gKwkJCS5z
aWduID0gJ3UnLAkJCQkJXA0KPiArCQkJLnJlYWxiaXRzID0gMTYsCQkJCQlcDQo+ICsJCQkuc3Rv
cmFnZWJpdHMgPSAxNiwJCQkJXA0KPiArCQkJLmVuZGlhbm5lc3MgPSBJSU9fQkUsCQkJCVwNCj4g
KwkJfSwJCQkJCQkJXA0KPiArCX0NCj4gKw0KDQouLi4NCg0KPiAgc3RhdGljIGludCBhZDQ2OTFf
cmVhZF9hdmFpbChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiBAQCAtNTQwLDEwICs2NTUs
MzAgQEAgc3RhdGljIGludCBhZDQ2OTFfcmVhZF9hdmFpbChzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5k
aW9fZGV2LA0KPiAgCXVuc2lnbmVkIGludCBzdGFydCA9IGFkNDY5MV9zYW1wX2ZyZXFfc3RhcnQo
c3QtPmluZm8pOw0KPiANCj4gIAlzd2l0Y2ggKG1hc2spIHsNCj4gLQljYXNlIElJT19DSEFOX0lO
Rk9fU0FNUF9GUkVROg0KPiAtCQkqdmFscyA9ICZhZDQ2OTFfb3NjX2ZyZXFzX0h6W3N0YXJ0XTsN
Cj4gKwljYXNlIElJT19DSEFOX0lORk9fU0FNUF9GUkVROiB7DQo+ICsJCXVuc2lnbmVkIGludCBv
c3IgPSBzdC0+b3NyW2NoYW4tPmNoYW5uZWxdOw0KPiArCQlpbnQgbiA9IDA7DQo+ICsNCj4gKwkJ
LyoNCj4gKwkJICogT25seSBvc2NpbGxhdG9yIGZyZXF1ZW5jaWVzIGV2ZW5seSBkaXZpc2libGUg
YnkgdGhlIGNoYW5uZWwncw0KPiArCQkgKiBPU1IgeWllbGQgYW4gaW50ZWdlciBlZmZlY3RpdmUg
cmF0ZTsgZXhwb3NlIHRob3NlIGFzIGVmZmVjdGl2ZQ0KPiArCQkgKiByYXRlcyAob3NjIC8gb3Ny
KSBzbyB0aGUgdXNlciB3b3JrcyBlbnRpcmVseSBpbiBvdXRwdXQtc2FtcGxlDQo+ICsJCSAqIHNw
YWNlLg0KPiArCQkgKi8NCj4gKwkJZm9yICh1bnNpZ25lZCBpbnQgaSA9IHN0YXJ0OyBpIDwNCj4g
QVJSQVlfU0laRShhZDQ2OTFfb3NjX2ZyZXFzX0h6KTsgaSsrKSB7DQo+ICsJCQlpZiAoYWQ0Njkx
X29zY19mcmVxc19IeltpXSAlIG9zciAhPSAwKQ0KPiArCQkJCWNvbnRpbnVlOw0KPiArCQkJc3Qt
PnNhbXBfZnJlcV9hdmFpbFtuKytdID0gYWQ0NjkxX29zY19mcmVxc19IeltpXSAvDQo+IG9zcjsN
Cj4gKwkJfQ0KPiArCQkqdmFscyA9IHN0LT5zYW1wX2ZyZXFfYXZhaWw7DQoNCiJUaGUgSUlPIGNv
cmUgY2FsbHMgcmVhZF9hdmFpbCgpIHdpdGhvdXQgaG9sZGluZyBkcml2ZXItbGV2ZWwgbG9ja3Mg
dGhhdA0Kc2VyaWFsaXplIHN5c2ZzIHJlYWRzLiBDYW4gY29uY3VycmVudCByZWFkcyBvZg0KaW5f
dm9sdGFnZU5fc2FtcGxpbmdfZnJlcXVlbmN5X2F2YWlsYWJsZSBmb3IgY2hhbm5lbHMgd2l0aCBk
aWZmZXJlbnQgT1NSDQp2YWx1ZXMgcmFjZSBhbmQgb3ZlcndyaXRlIHN0LT5zYW1wX2ZyZXFfYXZh
aWwgc2ltdWx0YW5lb3VzbHk/DQpUaGlzIGNvdWxkIHJlc3VsdCBpbiBpbnRlcmxlYXZlZCBvciBj
b3JydXB0ZWQgb3V0cHV0IGJlaW5nIGZvcm1hdHRlZCBieSB0aGUNCklJTyBjb3JlIGFuZCBzZW50
IHRvIHVzZXJzcGFjZS4gSXMgYSBwZXItY2hhbm5lbCBhcnJheSBvciBzeW5jaHJvbml6YXRpb24N
CnJlcXVpcmVkIGhlcmU/Ig0KDQpWYWxpZC4gU3lzZnMgc2VyaWFsaXplcyByZWFkcyB0byB0aGUg
c2FtZSBzeXNmcyBmaWxlIGJ1dCBub3QgYWNyb3NzDQpkaWZmZXJlbnQgY2hhbm5lbCBfYXZhaWxh
YmxlIGZpbGVzLiBDb25jdXJyZW50IHJlYWRzIG9mDQppbl92b2x0YWdlMF9zYW1wbGluZ19mcmVx
dWVuY3lfYXZhaWxhYmxlIGFuZA0KaW5fdm9sdGFnZTFfc2FtcGxpbmdfZnJlcXVlbmN5X2F2YWls
YWJsZSAod2l0aCBkaWZmZXJlbnQgT1NScykgcmFjZWQgb24NCnRoZSBzaGFyZWQgc2FtcF9mcmVx
X2F2YWlsW10gc2NyYXRjaCBhcnJheS4gTWFkZSBpdCBhIDJEIGFycmF5DQpbMTZdW05fT1NDX0VO
VFJJRVNdIHNvIGVhY2ggY2hhbm5lbCBoYXMgaXRzIG93biBzdWItYXJyYXk7IGNvbmN1cnJlbnQN
CnJlYWRzIGZvciBkaWZmZXJlbnQgY2hhbm5lbHMgbm8gbG9uZ2VyIGludGVyZmVyZS4NCg0KPiAg
CQkqdHlwZSA9IElJT19WQUxfSU5UOw0KPiAtCQkqbGVuZ3RoID0gQVJSQVlfU0laRShhZDQ2OTFf
b3NjX2ZyZXFzX0h6KSAtIHN0YXJ0Ow0KPiArCQkqbGVuZ3RoID0gbjsNCj4gKwkJcmV0dXJuIElJ
T19BVkFJTF9MSVNUOw0KDQouLi4NCg0KPiBAQCAtNjM0LDkgKzc4MCwyOSBAQCBzdGF0aWMgaW50
IGFkNDY5MV93cml0ZV9yYXcoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gIAkJCSAg
ICBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbiwNCj4gIAkJCSAgICBpbnQgdmFsLCBp
bnQgdmFsMiwgbG9uZyBtYXNrKQ0KPiAgew0KPiArCXN0cnVjdCBhZDQ2OTFfc3RhdGUgKnN0ID0g
aWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gKw0KPiAgCXN3aXRjaCAobWFzaykgew0KPiAgCWNhc2Ug
SUlPX0NIQU5fSU5GT19TQU1QX0ZSRVE6DQo+IC0JCXJldHVybiBhZDQ2OTFfc2V0X3NhbXBsaW5n
X2ZyZXEoaW5kaW9fZGV2LCB2YWwpOw0KPiArCQlyZXR1cm4gYWQ0NjkxX3NldF9zYW1wbGluZ19m
cmVxKGluZGlvX2RldiwgY2hhbiwgdmFsKTsNCj4gKwljYXNlIElJT19DSEFOX0lORk9fT1ZFUlNB
TVBMSU5HX1JBVElPOiB7DQo+ICsJCUlJT19ERVZfQUNRVUlSRV9ESVJFQ1RfTU9ERShpbmRpb19k
ZXYsIGNsYWltKTsNCj4gKwkJaWYgKElJT19ERVZfQUNRVUlSRV9GQUlMRUQoY2xhaW0pKQ0KPiAr
CQkJcmV0dXJuIC1FQlVTWTsNCj4gKw0KPiArCQlmb3IgKHVuc2lnbmVkIGludCBpID0gMDsgaSA8
DQo+IEFSUkFZX1NJWkUoYWQ0NjkxX292ZXJzYW1wbGluZ19yYXRpb3MpOyBpKyspIHsNCj4gKwkJ
CWlmIChhZDQ2OTFfb3ZlcnNhbXBsaW5nX3JhdGlvc1tpXSAhPSB2YWwpDQo+ICsJCQkJY29udGlu
dWU7DQo+ICsJCQkvKg0KPiArCQkJICogU3RvcmUgdGhlIG5ldyBPU1I7IHRhcmdldF9vc2NfZnJl
cV9IeiBpcw0KPiB1bmNoYW5nZWQuDQo+ICsJCQkgKiBUaGUgZWZmZWN0aXZlIHJhdGUgcmVhZCBi
YWNrIHZpYQ0KPiBpbl92b2x0YWdlTl9zYW1wbGluZ19mcmVxdWVuY3kNCj4gKwkJCSAqIGJlY29t
ZXMgdGFyZ2V0X29zY19mcmVxX0h6IC8gbmV3X29zcg0KPiBhdXRvbWF0aWNhbGx5Lg0KPiArCQkJ
ICovDQo+ICsJCQlzdC0+b3NyW2NoYW4tPmNoYW5uZWxdID0gdmFsOw0KDQoiV3JpdGluZyBvdmVy
c2FtcGxpbmdfcmF0aW8gdXBkYXRlcyBvc3IgYnV0IGxlYXZlcyB0YXJnZXRfb3NjX2ZyZXFfSHoN
CnVuY2hhbmdlZC4gRG9lcyB0aGlzIGJyZWFrIHRoZSB0YXJnZXRfb3NjX2ZyZXFfSHogJSBvc3Ig
PT0gMCBndWFyYW50ZWUNCmVuZm9yY2VkIGluIGFkNDY5MV9zZXRfc2FtcGxpbmdfZnJlcSgpPw0K
UmVhZGluZyBzYW1wbGluZ19mcmVxdWVuY3kgYWZ0ZXIgdGhpcyBjb3VsZCB5aWVsZCBhIHRydW5j
YXRlZCBpbnRlZ2VyLiBJZg0KdGhhdCBleGFjdCBpbnRlZ2VyIGlzIHdyaXR0ZW4gYmFjaywgaXQg
bWlnaHQgY29tcHV0ZSBhIHNtYWxsZXIgb3NjaWxsYXRvcg0KcmVxdWlyZW1lbnQgYW5kIHNuYXAg
dGhlIGRldmljZSB0byBhIGRpZmZlcmVudCwgbG93ZXIgb3NjaWxsYXRvciBmcmVxdWVuY3kuDQpE
b2VzIG1vZGlmeWluZyBvdmVyc2FtcGxpbmdfcmF0aW8gbmVlZCB0byByZWNhbGN1bGF0ZSB0YXJn
ZXRfb3NjX2ZyZXFfSHoNCnRvIG1haW50YWluIHN0YXRlIGNvbnNpc3RlbmN5PyINCg0KVmFsaWQu
IFN0b3JpbmcgYSBuZXcgT1NSIHdpdGhvdXQgdXBkYXRpbmcgdGFyZ2V0X29zY19mcmVxX0h6IGNh
bg0KYnJlYWsgdGhlIHRhcmdldF9vc2NfZnJlcV9IeiAlIG9zciA9PSAwIGludmFyaWFudC4gRm9y
IGV4YW1wbGUgd2l0aA0KdGFyZ2V0X29zY19mcmVxX0h6ID0gMjUwIGtIeiBhbmQgbmV3IE9TUiA9
IDMyOiByZWFkLWJhY2sgaXMNCjI1MDAwMCAvIDMyID0gNzgxMiAodHJ1bmNhdGVkKTsgd3JpdGlu
ZyB0aGF0IHZhbHVlIGJhY2sgY29tcHV0ZXMNCm5lZWRlZF9vc2MgPSAyNDk5ODQsIHNuYXBwaW5n
IHRoZSBvc2NpbGxhdG9yIHRvIHRoZSBuZXh0IGxvd2VyIHRhYmxlDQplbnRyeSDigJQgYSBzaWxl
bnQgZnJlcXVlbmN5IGNoYW5nZSBvbiB3aGF0IHRoZSB1c2VyIGV4cGVjdGVkIHRvIGJlIGENCm5v
LW9wIHdyaXRlLWJhY2suDQoNCkZpeGVkOiB0aGUgT1ZFUlNBTVBMSU5HX1JBVElPIHdyaXRlIHBh
dGggbm93IGNhbGxzIGFkNDY5MV9maW5kX29zY19mcmVxKCkNCndpdGggb2xkX2VmZmVjdGl2ZSAq
IG5ld19vc3IgYXMgdGhlIGNlaWxpbmcsIHdoZXJlDQpvbGRfZWZmZWN0aXZlID0gdGFyZ2V0X29z
Y19mcmVxX0h6IC8gb2xkX29zci4gVGhpcyBwcmVzZXJ2ZXMgdGhlDQpkaXZpc2liaWxpdHkgaW52
YXJpYW50IGFuZCBrZWVwcyB0aGUgb3NjaWxsYXRvciBhcyBjbG9zZSBhcyBwb3NzaWJsZSB0bw0K
dGhlIHByZXZpb3VzIGVmZmVjdGl2ZSByYXRlLg0KDQo+ICsJCQlyZXR1cm4gMDsNCj4gKwkJfQ0K
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICAJZGVmYXVsdDoNCj4gIAkJcmV0dXJuIC1F
SU5WQUw7DQo+ICAJfQ0KPiBAQCAtNjkxLDYgKzg1NywxMCBAQCBzdGF0aWMgaW50IGFkNDY5MV9l
bnRlcl9jb252ZXJzaW9uX21vZGUoc3RydWN0DQo+IGFkNDY5MV9zdGF0ZSAqc3QpDQo+ICAJCXJl
dHVybiByZWdtYXBfdXBkYXRlX2JpdHMoc3QtPnJlZ21hcCwNCj4gQUQ0NjkxX0RFVklDRV9TRVRV
UCwNCj4gIAkJCQkJICBBRDQ2OTFfTUFOVUFMX01PREUsDQo+IEFENDY5MV9NQU5VQUxfTU9ERSk7
DQo+IA0KPiArCXJldCA9IGFkNDY5MV93cml0ZV9vc2NfZnJlcShzdCk7DQo+ICsJaWYgKHJldCkN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiAgCXJldCA9IHJlZ21hcF91cGRhdGVfYml0cyhzdC0+
cmVnbWFwLCBBRDQ2OTFfQURDX1NFVFVQLA0KPiAgCQkJCSBBRDQ2OTFfQURDX01PREVfTUFTSywN
Cj4gQUQ0NjkxX0NOVl9CVVJTVF9NT0RFKTsNCj4gIAlpZiAocmV0KQ0KPiBAQCAtODQ0LDYgKzEw
MTQsMTIgQEAgc3RhdGljIGludA0KPiBhZDQ2OTFfY252X2J1cnN0X2J1ZmZlcl9wcmVlbmFibGUo
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycl91
bm9wdGltaXplOw0KPiANCj4gKwlpaW9fZm9yX2VhY2hfYWN0aXZlX2NoYW5uZWwoaW5kaW9fZGV2
LCBpKSB7DQo+ICsJCXJldCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2OTFfQUNDX0RF
UFRIX0lOKGkpLA0KPiBzdC0+b3NyW2ldKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWdvdG8gZXJy
X3Vub3B0aW1pemU7DQo+ICsJfQ0KPiArDQoNCiJJZiB0aGUgSUlPIHNvZnQgdGltZXN0YW1wIGNo
YW5uZWwgaXMgZW5hYmxlZCwgaXRzIHNjYW5faW5kZXggaXMgMTYuDQppaW9fZm9yX2VhY2hfYWN0
aXZlX2NoYW5uZWwoKSBpdGVyYXRlcyBvdmVyIGFsbCBhY3RpdmUgY2hhbm5lbHMgaW5jbHVkaW5n
DQp0aGUgdGltZXN0YW1wIGNoYW5uZWwuDQpXaWxsIHRoaXMgbG9vcCBwcm9jZXNzIGkgPSAxNiBh
bmQgYWNjZXNzIHN0LT5vc3JbMTZdIG91dCBvZiBib3VuZHMsIHNpbmNlDQpzdC0+b3NyIGlzIGFu
IGFycmF5IG9mIHNpemUgMTY/DQpBZGRpdGlvbmFsbHksIHNpbmNlIEFENDY5MV9BQ0NfREVQVEhf
SU4oMTYpIHJlc29sdmVzIHRvIDB4MTk2DQooQUQ0NjkxX0dQSU9fTU9ERTFfUkVHKSwgd2lsbCB0
aGlzIHNpbGVudGx5IGNvcnJ1cHQgdGhlIEdQSU8gY29uZmlndXJhdGlvbg0KYW5kIHBvdGVudGlh
bGx5IGJyZWFrIHRoZSBEQVRBX1JFQURZIGludGVycnVwdD8NCkZ1cnRoZXJtb3JlLCBkb2VzIHRo
ZSBwcmVzZW5jZSBvZiB0aGUgdGltZXN0YW1wIGNoYW5uZWwgY2F1c2UgdGhlIGxvb3ANCml0ZXJh
dGlvbiB0byBhZHZhbmNlIGsgdG8gMTcsIG1ha2luZyB0aGUgc3RhdGUtcmVzZXQgU1BJIHRyYW5z
ZmVycyBhcHBlbmRlZA0KYWZ0ZXIgdGhlIGxvb3Agd3JpdGUgdG8gc3QtPnNjYW5feGZlcnNbMzRd
IGFuZCBbMzVdPyBUaGlzIHdvdWxkIG92ZXJmbG93DQp0aGUgc2Nhbl94ZmVycyBhcnJheSB3aGlj
aCBpcyBzaXplZCAzNCBhbmQgY291bGQgY29ycnVwdCB0aGUgc3Vycm91bmRpbmcNCnN0cnVjdCBh
ZDQ2OTFfc3RhdGUuIg0KDQpWYWxpZCBmb3IgdGhlIG9zcltdIG91dC1vZi1ib3VuZHMgYW5kIEdQ
SU8gY29ycnVwdGlvbiBjb25jZXJucy4gV2l0aA0KdGhlIHNvZnQgdGltZXN0YW1wIGVuYWJsZWQg
KHNjYW5faW5kZXggPSAxNiksIHRoZSBsb29wIHdvdWxkIGFjY2Vzcw0Kc3QtPm9zclsxNl0gb3V0
LW9mLWJvdW5kcyBhbmQgd3JpdGUgdG8gQUQ0NjkxX0FDQ19ERVBUSF9JTigxNikgPSAweDE5NiwN
CndoaWNoIGlzIEFENDY5MV9HUElPX01PREUxX1JFRywgc2lsZW50bHkgY29ycnVwdGluZyB0aGUg
R1BJTyBjb25maWd1cmF0aW9uDQphbmQgcG90ZW50aWFsbHkgYnJlYWtpbmcgdGhlIERBVEFfUkVB
RFkgaW50ZXJydXB0Lg0KDQpBZGRlZCB0aGUgc2FtZSBndWFyZCB1c2VkIGJ5IHRoZSBzY2FuX3hm
ZXJzIGxvb3BzIGluIHRoZSB0cmlnZ2VyZWQtYnVmZmVyDQpjb21taXQ6IGlmIChpID49IGluZGlv
X2Rldi0+bnVtX2NoYW5uZWxzIC0gMSkgYnJlYWsuDQoNClRoZSBzY2FuX3hmZXJzIGstb3ZlcmZs
b3cgY29uY2VybiBpcyBhbHJlYWR5IGhhbmRsZWQgYnkgdGhhdCBleGlzdGluZyBndWFyZA0KaW4g
YSBzZXBhcmF0ZSBsb29wIOKAlCBpdCBpcyBub3QgYWZmZWN0ZWQgYnkgdGhlIEFDQ19ERVBUSF9J
TiBsb29wIGFkZGVkDQpoZXJlLg0KDQo=

