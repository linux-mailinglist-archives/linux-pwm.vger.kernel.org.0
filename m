Return-Path: <linux-pwm+bounces-8212-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JfCL8iLrmnNFwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8212-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Mar 2026 09:58:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207CF235C5B
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Mar 2026 09:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02675300A8E0
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2026 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5D370D62;
	Mon,  9 Mar 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k4pITOW0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A0341076;
	Mon,  9 Mar 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046688; cv=fail; b=ZjfvII2uywO7VgBwTcfaRpC7bTjbjmdAAf6U2hl9wHBOFrgPOiziSf0xfnwPFG34+etELCiFCl6U6s3EoL2Ta7HDJI2GnqKrsV7r841CGUFMpOUiOVcB1dHxdE7gcErOp31zebpBjmETv++tFMhKpZAFujXRlWFtjNwbeuqQxJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046688; c=relaxed/simple;
	bh=6FAk41CwsRphR8ITHr5ILzIWhocIfiW9jDHBqgGQCp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kSxQ45IEYBVeoHAg7VLAJIReMgVBP5Fh1enOX3hOMYMwsq8RRFer4q/2ImBk9k6GW4UprE2kmXiGzkkJorWvWprVDsjVLZ5uE9LvD3JFH8di1dTaP39Z7qOp2ywTgBmUsDpO3Pb0MKXOz7q4yhOM7NMHyKxfSHt+pujP6eheXh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k4pITOW0; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298ZeR93618919;
	Mon, 9 Mar 2026 04:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6FAk4
	1CwsRphR8ITHr5ILzIWhocIfiW9jDHBqgGQCp4=; b=k4pITOW0Z+Srwbimm3DDM
	VCHtSTn7h6oeWExS8Ba38EuLsVThA5cfKsRmFh/CZmyzlLUHGJU6GIPmi3IABbMz
	VN+xdZboiA28zAic2Rx3Xskg8neMj3tVgupo04SMmdepmh8NlEozKWiLpPLAknyo
	oZxTV5f7ds5RSS1DmkXH2oOale9xCPIeiXdiWXGw3nB+Pj5P2fy0dIJ1nOK3bgQH
	KBdCSdgBx4vehwygXdjhxhAVtb4h/tTNhdSdGxDo2lDnywjJzRnkz+kbXfFy1QKZ
	aGfCVGIdnERqlIR/Ge0baUT8yCTo/bCUCCRpgE+6UG0vrKJa4b0h4PFCi2X0DU3R
	A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cren9ndhk-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 04:57:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1BliAEn/QZvGhjh2eJysUvzNzaMJanp3zFFravA4QhpVWUtwxuIVs4gs5eUu86d74MIW6ao5jW3T8b76luwToDbGf1Zez/NwbaUhAw1PqAz98Y/OwIAJtTdbvGu/n9Oij7YU9fwNp5juVFdk7Rgpk+990E6peVcM6K4012wCa6fLTQ6u6mwSc6f0kIPCq8EapRonoDBVaXNj6mCCDSIAyrIoM55QZHKwPm7iwyA2wi5bgMvs1d8DZa2K5VXcfVFPy5vi+zMd9PkKJWnjRYAb4zCIZMJth5VlW3iey7bxfloVSQyE/ruifPAYlHv7tkedE1nb/SgG+pRe5hOgPPt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FAk41CwsRphR8ITHr5ILzIWhocIfiW9jDHBqgGQCp4=;
 b=MAbdVnFxX4c1Syec7wAhof1gC2kg5kUmk/8hPWVaTWxHaxVYJt+8/R1WyV+JY9FZisjtBp3n63aEL2LF9v45jTg5mbNY2gvuj/qSZEjrpve+Gympk9vwceyRxTtqjFfXbP/REoVKOPTPYK2qPoGMft5C6FZraTDqmgYS/XATHLP+F8W+f+2NkDRZAN1a8lwebJp6exnkvV56ZmNKzNcV0aQdhXr2eFK7auTKCZQuJJE4P7QRiqsAXIuCyC317+AEYguDj1gLjfWiuJ1dilQCx0MA/zFdup2nLNGbvNAf1b3tdD+IL1zV/mugWm+iMPxMDn2myVvLu9R+YwmTbDiCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by BL1PR03MB6152.namprd03.prod.outlook.com (2603:10b6:208:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 08:57:33 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:57:32 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691 family
Thread-Topic: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Index: AQHcrJrnOQr61vQ0mEuBvbjSZ+4EebWgNqSAgAEV+KCAAiA0gIABjL6AgADugYA=
Date: Mon, 9 Mar 2026 08:57:32 +0000
Message-ID:
 <SA5PR03MB842501D7A27A10BC203E5433F779A@SA5PR03MB8425.namprd03.prod.outlook.com>
References:
 <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
	<20260305174559.1ded5173@jic23-huawei>
	<LV9PR03MB84149F32D4CABA4D2827D85BF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
	<08717cd6-a732-4f06-a6f1-8cbdaa755b78@baylibre.com>
 <20260308182839.19587743@jic23-huawei>
In-Reply-To: <20260308182839.19587743@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|BL1PR03MB6152:EE_
x-ms-office365-filtering-correlation-id: 3d82eb4a-f395-46af-49e0-08de7db9e69a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 FwKmitPme7DBgc2AJJTlWIEKWLfhfCQwHC3EvIDVTNWyJEeByYGX/GoYZMWdEuO5qLfHeNv41A0dMmemiNt3sunROQdjAT8IFvYs9YUSy0Rok7TtcwLSnrBwuOp+BUSKES9e0RhyeA4hpSCEMEHuuJE+eEjZ96LOwU3rnv9DyY9wU8brSY/jGH6O+z91NV0fTlnbb1HwLuoF+0QfarQOUOSaGiiLmgBXJAynMKQrrlxx6cVmS4OL3ALxEiuNGEz7rTWhcTnk09vNIlPXJ2ILgC6jWjIsKOdUYF/NxbaMF7WRu+1qokWGgqH2jLdvZUUmJz1m3J00QDqMIPOBIMr4D9YankLZGGcnBRSAc5QtUatkW83ZjlhLxWG/MzM28lHNgw7jkLxDUnyF3xzp67xMtqSoKy9Ac9y2rqjWhm1BcaHZQ5N43801Gyjp63K4Mcrw3K09jB3KA2c7adVH8D1Ldj0ZYtKhLV2XRTGo9XJShFVgxjYCpdqmGu1hyiI8bjLvAD17dX3p2VNsidHplE+i9Yx2fb878rz0vYhZXKUa8r5RDEAwPrLmEwIz/HVv5X7CP8CBcUQGEJRWr5RpIJwB6dnp1rqCAK1q9mfuMsSEuOcPVfNrPLhZAqiSLf4IBeKH98Kg1wskr++KTTMB09YlS6rLL0c68XQIy5znNQQ01ysIU14zM+w6WSkGvICgLi6S94w01TZvlaZaHPDv9UDkULu4mFrXoG6AjbAUpECq4vWkv1DlbRFvwTA62zPSXM3T3Ui0sDmzfHucOk7GDVr4fphov+mUmsQIBBHXrehVsFU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGVHV280cUR1UmpzT1lWL2FBTDhWZHdCRWF6QjViWHVmdGdoc2M1YzI1U0VV?=
 =?utf-8?B?ajFERmNiNE83QWlxQTJaUHk5bWVVVGl1TkovcFNLMUYrRkFNUndrVlVLTCtI?=
 =?utf-8?B?TndvT1IwelRqUURreUpuYmxwSU9GTmN3M1V1d2NHQ2s0UGlGRW05WWZiMUlH?=
 =?utf-8?B?cE90dWJ3cVMrMUIvMjN3ZHNVUkMrUnJRam83eGEwYkk0N2VUSnV0K25XWGNS?=
 =?utf-8?B?ZW5FRmQ5d2g1cUxFVlpXblBGUENxT2lSWksyckJPdGU2U0ZxRWhnUWlRQUdy?=
 =?utf-8?B?K3lyd0ZtNGo4MHhQVFZFSlg2SWtaVDhlVHVpeU5xcFJ3ZklRa1k0VERtSjlw?=
 =?utf-8?B?b2ZpTEplNDdFcXNOeW9CMmlQNGpNUEFobC9mNDd4UHlhQVZIT29TdEVFWVF0?=
 =?utf-8?B?dEhjVjljeDd6Wm0xUEQ1YXdnVDlreDZTQUswZ1crc1ZMY0VKUG9md1B1Z015?=
 =?utf-8?B?QWc3dENzSWJHaWYwVStBTFhsVUpBMFd0NDdlWnUxM2JwSDlJTzZaNzJiN2JO?=
 =?utf-8?B?Y1ZGL05nWFVRcVE2eWxKbmZuWWRmTnRSeU1yejBjMjFlOUdoT1lrK2tQUXR1?=
 =?utf-8?B?bXpZOUtqUUV5UDIvREFnRWZEYmxPdWYvK2cvVTlqWlNieUJuYk5GVU84UWxv?=
 =?utf-8?B?VlFvTEdHWWZuV3gyWkNld2U5VEZ5ZGZ3dWZ4UWpaR0JtWmpEZUU0Rmc3Z3pr?=
 =?utf-8?B?Nmp1MXA1YndzQzZJWC9NWDE1SGxPUm1YWHVaUDJVdXVwd3hIL1E2QnIwd0Jn?=
 =?utf-8?B?dzVWQ3BDYjA1RUl0ak0xaWxlbStUeVRuclQ1L1ZYYmdKcmw1cVFBeU1hQmJK?=
 =?utf-8?B?U3JWMzVrMk9LWStLR2tWZy81T1JQQktNSHIwRVJaeHFRem9MNEpOQ2hreUsr?=
 =?utf-8?B?RURWbCttNlJKaDI1SCtNdmd6d3VVTzBTS1RVaU10czhwVjdqbk9hUE0vSnlW?=
 =?utf-8?B?TTZJVTR4VTRZZWkwOFJUanhGMEJzTENZOGFvd2xLdkVzUWNXelR3eUZXNktP?=
 =?utf-8?B?WkNQcDNoQ29HL1RPWUlpNlNvc045SHpYemZHNEdDanlxY0M2TWMxUmt6bFBS?=
 =?utf-8?B?dnNTU3pBWjcyeVprbEc4NmVlZFp2cjJTVnlGZmZDS2I3eFVLczJBNDg5Ry83?=
 =?utf-8?B?TUt3dHhWQUVVWlhXZldWSTB0ZFVpQWl3YUwxKzlhYUM0b0lGek5STFFFVmlS?=
 =?utf-8?B?cVpoc0RuK2F4RUtHZEVkYmFiVUhOaW1qSnF1WjNJUUlzS0dDVVUydE9YOFlK?=
 =?utf-8?B?anlzNnFBS0lNeVRFT1pTZkt5aENWTElhaXd1Q2JJbmFYWXRlYnloZEw4Z281?=
 =?utf-8?B?dTNHOGtQS3BBYmhzem1pQnU1bnllbjRNU1lyYUNvOWxsY20veUFHS2o5dXZu?=
 =?utf-8?B?YTF5ZnNTR2lvZTNwTWxTM1h1UWtMaFdQRTVqVXBZOHNkTmNmL2tVdHlsc210?=
 =?utf-8?B?QUtQVzRhanczbUdTYU14d0FUbytvODdxb3h4UW9YbzQzbFVlZ3J0VlZ4NEdv?=
 =?utf-8?B?TkxSNW5ucjIxaHdaZGx6UkJOSEZHRmhJYTVWWWhMVTlEb1E1cUhRaE9aNldT?=
 =?utf-8?B?WkFqMHJSaFczRlUxTFFWSWJLaVQxOTlyVVFOcEJrMDFBZUVzelRWUzJOc1Q2?=
 =?utf-8?B?aWdMdy9HT1p2RkpLanc5SFB5S25uVHRSQi9xZk9QUkFsb1h2aUgrTnVta1pt?=
 =?utf-8?B?aGpOaHkzNUthU1JxbVJCS1FaWU5tUE9ZVGF0TjV5cFJYRmlQeDQwbVB0RnZJ?=
 =?utf-8?B?OFQrZVhIOEl5aklDSEVxYkxJbFhtWVZLM1lyOHhnTXYrL3kxVUlXOGV4RjVN?=
 =?utf-8?B?c0tIdzc5WlR4QU00bzdZNzVhN3hEQmZaeW1qSXoySFpmVUUvR003aFVHUkFG?=
 =?utf-8?B?VHJGTHlKdTlsTHFBeGRQSk5GWlJSbzVBaUtMZDdTMHFnRGJVWFcxOHRGdER4?=
 =?utf-8?B?Z3BBVXp0U0F6ZkwrRWF4akxYZkIzdnAzUEwrTXcrK2FHSm4rdFN0VmF4MytZ?=
 =?utf-8?B?NVNCSXVZRmthTFExOFhQT0MxRWw5UHlweENuV2t5dUtLNUhCNjkvekthTnE5?=
 =?utf-8?B?aFJhZVpscWdkS1k4bVJsSktEWm5VbzA4ZHBYWDdWSDhDaDA1YTdpZjBPMk13?=
 =?utf-8?B?UGJESUduUlFJRjFZSS9reTVvQ3RLYUZKaVlkUTRGNHlQUTFFS3RxaUI4c3Fp?=
 =?utf-8?B?SnNPMXFuSFR5elp5SlhlaXhvWUpJVUpaWGNFL2U2UFVqcWtTMVFEUEhYQjg1?=
 =?utf-8?B?U0NaNzFPaG50ekY4bHlLVEdBYXhmZTJzZFFGVnpEYTZzNnlFMS9LMEUyZ3Zy?=
 =?utf-8?B?NTZXU0U0czJwS2VEY2pqS3Q1c1lrc0RaNFB4dkRKWXdKZE5HRCtmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	g8pnO9s6FB3KSKFbh5xzlwo91xG+pPlPao21dHYOOx4aYT7Vic9JKLE8H5h7dpXwaGFD6wg0kN83D4T6qdq0RCO3KA9k1NH/kQOqwo0sAhUSmSlEAAhZt1iU5Zm0f1JxU25f8eQIeOo3iRvO07k3p+CjCrrPN20flt1ZP+EEkkS7T5QE7PdfDEp4dc71q/wQZaFG9X6S/c3pLWZt2xXVq8K1QKrevhcxy+jaVilZBXhTkXYfLkbY3tBKT19n8spWd0rW8iincTHS0ZY6e4Ps6v9S+L5iPy5U7MyXbwuQWYW6TEV0EkBghXB0XBU8YG1OE3VEpnI2oi+sarPyk1vb6Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d82eb4a-f395-46af-49e0-08de7db9e69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 08:57:32.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPUHUnL95hf9bO4NNw9slH5A1YaF9Lc2EA9XvT2r/tquoOHtD8JzuFAWz9+b7xJqWE15Vwv3QZMcJiWF0YhRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6152
X-Proofpoint-GUID: DVKjbTTPXS70Y3Jn6guNitGrpfoBTRDE
X-Authority-Analysis: v=2.4 cv=O9A0fR9W c=1 sm=1 tr=0 ts=69ae8b80 cx=c_pps
 a=ReLZl+GdXdFt35wSL8r9Ug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=G9g-uqL-ENfZw1q8yw8A:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4MSBTYWx0ZWRfX3j8AfMaHrw5x
 +VN9to9YIpIHxLCN1q/JUmXPKO3O9URXRGZYTT4+u82dAngCIAgjqdrct+0UhCfquMiks2UzXb3
 HFwIPtQDZh0fjmzWh74F1zMP8K+ecZhoshYfofEd9Dq4Re2xCrCA6j0blHz9kkQ5yZCSQjsqvNP
 207nWvg54kXCYcd43HPvSFuBJj/WQ03XwuTa8mCrrEASH9TKFfp7QsqGiWkoVTYsFII9Z7btzAp
 9LtEGhJSPHndgMdiWDYP0w6mZEiH7aXX4TBIRFGGpqc/D6fT3LMBTKW9VV+w+XuFUoY1vhiOKvn
 sOZZGSLrw5blnbjdc7oxvVtHV1AFAi2SW/HbiB0E2whTOyvh0sRzYerynyo4e4UZUX/J4CxRik8
 B0Nd53TvxMmbPGHWga+AyDBh271/v6nThDBBq6SCCFnw1P0pzxPm8/f+pvrzNL0JXo0vteHZEyO
 EOOwPbj+PGf+lneMDRA==
X-Proofpoint-ORIG-GUID: DVKjbTTPXS70Y3Jn6guNitGrpfoBTRDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090081
X-Rspamd-Queue-Id: 207CF235C5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8212-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,metafoo.de,analog.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBNYXJjaCA4LCAyMDI2IDg6Mjkg
UE0NCj4gVG86IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gQ2M6IFNh
YmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsgUmFkdSBTYWJhdSB2aWEg
QjQgUmVsYXkgPGRldm51bGwrcmFkdS5zYWJhdS5hbmFsb2cuY29tQGtlcm5lbC5vcmc+OyBMYXJz
LQ0KPiBQZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hhZWwg
PE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cu
Y29tPjsgQW5keQ0KPiBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgVXdlIEtsZWluZS1Lw7Zu
aWcgPHVrbGVpbmVrQGtlcm5lbC5vcmc+OyBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwu
Y29tPjsgTWFyayBCcm93bg0KPiA8YnJvb25pZUBrZXJuZWwub3JnPjsgTGludXMgV2FsbGVpaiA8
bGludXN3QGtlcm5lbC5vcmc+OyBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+
OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRd
IGR0LWJpbmRpbmdzOiBpaW86IGFkYzogYWRkIGJpbmRpbmdzIGZvciBBRDQ2OTEgZmFtaWx5DQo+
IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTYXQsIDcgTWFyIDIwMjYgMTI6NDg6MzkgLTA2MDAN
Cj4gRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPiB3cm90ZToNCj4gDQo+ID4g
T24gMy82LzI2IDU6NTUgQU0sIFNhYmF1LCBSYWR1IGJvZ2RhbiB3cm90ZToNCj4gPiA+DQo+ID4g
Pg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4gRnJvbTogSm9uYXRo
YW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gPiA+PiBTZW50OiBUaHVyc2RheSwgTWFy
Y2ggNSwgMjAyNiA3OjQ2IFBNDQo+ID4gPj4gVG86IFJhZHUgU2FiYXUgdmlhIEI0IFJlbGF5IDxk
ZXZudWxsK3JhZHUuc2FiYXUuYW5hbG9nLmNvbUBrZXJuZWwub3JnPg0KPiA+ID4+IENjOiBTYWJh
dSwgUmFkdSBib2dkYW4gPFJhZHUuU2FiYXVAYW5hbG9nLmNvbT47IExhcnMtUGV0ZXIgQ2xhdXNl
biA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+ID4gPj4gPE1pY2hhZWwu
SGVubmVyaWNoQGFuYWxvZy5jb20+OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5j
b20+OyBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+ID4g
Pj4gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNv
bm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiA+ID4+IFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5la0Br
ZXJuZWwub3JnPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsgQnJv
d24gPGJyb29uaWVAa2VybmVsLm9yZz47IExpbnVzDQo+IFdhbGxlaWoNCj4gPiA+PiA8bGludXN3
QGtlcm5lbC5vcmc+OyBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+OyBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+ID4gPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvNF0gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBhZGQgYmluZGluZ3MgZm9yIEFENDY5MSBmYW1p
bHkNCj4gPiA+Pg0KPiA+ID4+IFtFeHRlcm5hbF0NCj4gPiA+Pg0KPiA+ID4+IE9uIFRodSwgMDUg
TWFyIDIwMjYgMTQ6MjM6MjcgKzAyMDANCj4gPiA+PiBSYWR1IFNhYmF1IHZpYSBCNCBSZWxheSA8
ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPj4N
Cj4gPiA+Pj4gRnJvbTogUmFkdSBTYWJhdSA8cmFkdS5zYWJhdUBhbmFsb2cuY29tPg0KPiA+ID4+
Pg0KPiA+ID4+PiBBZGQgWUFNTCBiaW5kaW5ncyBhbmQgZHQtYmluZGluZ3MgaGVhZGVyIGZvciB0
aGUgQW5hbG9nIERldmljZXMgQUQ0NjkxDQo+ID4gPj4+IGZhbWlseSBvZiBtdWx0aWNoYW5uZWwg
U0FSIEFEQ3MgKEFENDY5MSwgQUQ0NjkyLCBBRDQ2OTMsIEFENDY5NCkuDQo+ID4gPj4+DQo+ID4g
Pj4+IFRoZSBiaW5kaW5nIGRlc2NyaWJlcyBmaXZlIG9wZXJhdGluZyBtb2RlcyBzZWxlY3RhYmxl
IHZpYSB0aGUNCj4gPiA+Pj4gYWRpLHNwaS1tb2RlIHByb3BlcnR5LCBvcHRpb25hbCBQV00vY2xv
Y2sgZm9yIENOViBDbG9jayBhbmQgQ05WIEJ1cnN0DQo+ID4gPj4+IG1vZGVzLCBHUElPIHBpbnMs
IHZvbHRhZ2Ugc3VwcGxpZXMgYW5kIHRoZSB0cmlnZ2VyLXNvdXJjZSBpbnRlcmZhY2UgZm9yDQo+
ID4gPj4+IFNQSSBFbmdpbmUgb2ZmbG9hZCBvcGVyYXRpb24uDQo+ID4gPj4+DQo+ID4gPj4+IFNp
Z25lZC1vZmYtYnk6IFJhZHUgU2FiYXUgPHJhZHUuc2FiYXVAYW5hbG9nLmNvbT4NCj4gPiA+Pg0K
PiA+ID4+IEhpIFJhZHUsIEknbSBnb2luZyB0byBmb2N1cyBvbiBtb2RlLi4uIE1vc3RseSBiZWNh
dXNlIHRoaW5ncyBjYWxsZWQNCj4gPiA+PiBtb2RlIGFyZSB1c3VhbGx5IGEgc2lnbiBvZiBtaXhp
bmcgdXAgZGlmZmVyZW50IGFzcGVjdHMgb2YgdGhlIGJvYXJkDQo+ID4gPj4gZGVzaWduLi4uDQo+
ID4gPj4NCj4gPiA+IEhpIEpvbmF0aGFuLCBLcnlzenRvZiwNCj4gPiA+DQo+ID4gPiBUaGFuayB5
b3UgZ3V5cyBzbyBtdWNoIGZvciB5b3VyIHJldmlldy4NCj4gPiA+DQo+ID4gPiBSZWdhcmRpbmcg
J21vZGUnLCBJIGFncmVlIHRoYXQgaXQgc2hvdWxkIGJlIHNvbWV0aGluZyB0aGF0IGNvdWxkIGJl
IG1vZGlmaWVkDQo+ID4gPiBhdCBydW4tdGltZSwgZXNwZWNpYWxseSBzaW5jZSBhbGwgcmVnaXN0
ZXIgbW9kZXMgKENOVl9DTE9DSywgQ05WX0JVUlNULA0KPiA+ID4gQVVUT05PTU9VUyBhbmQgU1BJ
X0JVUlNUKSByZWx5IG9uIHRoZSBzYW1lIHByaW5jaXBsZXMgb2YgcmVhZGluZyB0aGUNCj4gPiA+
IEFEQyByZXN1bHQgZnJvbSB0aGUgcmVnaXN0ZXJzLCB0aGUgbWFpbiBkaWZmZXJlbmNlIGJlaW5n
IHRoYXQgUFdNIG9uIHRoZQ0KPiA+ID4gQ05WIHBpbiBpcyByZXF1aXJlZCBmb3IgQ05WX0NMT0NL
IGFuZCBDTlZfQlVSU1QsIGJ1dCB0aGUgYm9hcmQgZGVzaWduDQo+ID4gPiBzdGF5cyB0aGUgc2Ft
ZS4gUGVyaGFwcyB0aGlzIFBXTSBjYW4gYmUgaW5pdGlhbGl6ZWQgYXQgc3RhcnQtdGltZSBhbmQg
b25seQ0KPiA+ID4gYmUgdXNlZCB3aGVuIENOViBtb2RlcyBhcmUgYmVpbmcgdXNlZC4gVGhpcyB3
b3VsZCBtZWFuIG1vZGUgY2FuDQo+ID4gPiBiZWNvbWUgYW4gSUlPIGF0dHJpYnV0ZSB0aGF0IGNv
dWxkIGJlIHNldCBieSB0aGUgdXNlciBhdCBydW4tdGltZS4NCj4gPg0KPiA+IE1vcmUgbGlrZWx5
LCBpdCB3b3VsZCBiZSB0d28gZGlmZmVyZW50IHdheXMgb2YgZG9pbmcgYSBidWZmZXJlZCByZWFk
LA0KPiA+IHNvIG1heWJlIHR3byBkaWZmZXJlbnQgYnVmZmVycz8gT3IganVzdCBwaWNrIHRoZSAi
YmVzdCIgb25lIGFuZCBvbmx5DQo+ID4gaW1wbGVtZW50IHRoYXQgbW9kZS4NCj4gDQo+IEkgJ3Ro
aW5rJyBidXJzdCBtb2RlIGlzIHJlYWxseSBhbiBvdmVyc2FtcGxpbmcgdGhpbmcgYXMgeW91IHJl
YWQgYmFjayBmcm9tDQo+IGVpdGhlciB0aGUgb3V0cHV0IG9mIGFuIGF2ZXJhZ2luZyBmaWx0ZXIg
b3IgYW4gYWNjdW11bGF0b3IuDQo+IEkgZG91YnQgdGhlcmUgaXMgcmVhc29uIHRvIHN1cHBvcnQg
Ym90aCB0aGUgb3ZlcnNhbXBsZWQgYW5kIHJhdw0KPiByZWFkaW5ncyBhdCB0aGUgc2FtZSB0aW1l
Lg0KPiANCg0KSSBhZ3JlZSB3aXRoIHRoYXQsIHBlcmhhcHMgYnVyc3QgbW9kZXMgKENOVl9CVVJT
VCBhbmQgU1BJX0JVUlNUKSBjb3VsZA0KYmUgZHJvcHBlZC4gQWxzbywgQVVUT05PTU9VUyBtb2Rl
IGNvdWxkIGJlIHVzZWQgZm9yIHJlYWRfcmF3IHNpbmNlDQppdHMgY29tcGF0aWJsZSB3aXRoIGJv
dGggQ05WX0NMT0NLIGFuZCBNQU5VQUwgaGFyZHdhcmUgc2V0dXBzLg0KU28sIHRoZW4gaWYgdGhl
ICdwd20nIGlzIHByZXNlbnQgaW4gdGhlIGRldmljZSB0cmVlLCBDTlZfQ0xPQ0sNCndpbGwgYmUg
dXNlZCBmb3IgYnVmZmVyZWQgcmVhZGluZ3MgYW5kIGlmIG5vdCwgTUFOVUFMIHdpbGwuDQpUaGlz
IHdpbGwgaW5kZWVkIG5vdCBvbmx5IHNpbXBsaWZ5IHRoZSBkcml2ZXIsIGJ1dCBhbHNvIGtlZXAg
dHdvIGltcG9ydGFudA0KbW9kZXMgdXAgZm9yIGNob2ljZSBmb3IgdGhlIHVzZXIuDQoNClBsZWFz
ZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIG9uIHRoaXMgYXBwcm9hY2guDQoNCj4gPg0KPiA+
ID4NCj4gPiA+IEhvd2V2ZXIgZm9yIE1BTlVBTCwgbW9kaWZpY2F0aW9ucyBvZiBqdW1wZXIgcmVz
aXN0b3JzIG9uIHRoZSBwaHlzaWNhbA0KPiA+ID4gYm9hcmQgaXMgcmVxdWlyZWQgZm9yIHByb3Bl
ciBmdW5jdGlvbmFsaXR5LCBzaW5jZSB0aGUgQ05WIHBpbiBuZWVkcyB0byBiZQ0KPiA+ID4gdGll
ZCB0byBDUyBpbiB0aGlzIG1vZGUuIFdvdWxkIGl0IGJlIHByZWZlcnJlZCBpZiBiaW5kaW5ncyB3
b3VsZCBoYXZlIGENCj4gPiA+ICdyZWdpc3Rlci1tb2RlJyBhdHRyaWJ1dGUgKHRoZSBuYW1lIGNv
dWxkIGJlIGJldHRlcikgd2hpY2ggY2FuIGhhdmUgdmFsdWVzDQo+ID4gPiBsaWtlIDEocmVnaXN0
ZXIgbW9kZXMgYXJlIHVzZWQpIGFuZCAxKG1hbnVhbCBtb2RlIGlzIHVzZWQpLCBhbmQgZm9yDQo+
ID4gPiByZWdpc3RlciBtb2RlcywgaGF2ZSBhIGdsb2JhbCBJSU8gYXR0cmlidXRlIHRoYXQgY2Fu
IHN3aXRjaCBiZXR3ZWVuDQo+ID4gPiB0aGVtPw0KPiA+ID4NCj4gPg0KPiA+IFRoZSBiaW5kaW5n
IHNob3VsZCBkZXNjcmliZSBob3cgdGhlIGNoaXAgaXMgd2lyZWQgdXAuIFNvIHJhdGhlciB0aGFu
IHRoaW5raW5nDQo+ID4gYWJvdXQgbW9kZXMsIHRyeSB0aGlua2luZyBpbiB0ZXJtcyBvZiBjb25u
ZWN0aW9ucy4gQmFzZWQgb24gd2hhdCB0aGUgZGV2aWNldHJlZQ0KPiA+IHNheXMgaXMgY29ubmVj
dGVkLCB0aGUgZHJpdmVyIGNhbiB0aGVuIGluZmVyIHdoaWNoIG1vZGVzIGFyZSBhY3R1YWxseSBw
b3NzaWJsZS4NCj4gPg0KPiA+IEJyaW5naW5nIGJhY2sgc29tZSBjb250ZXh0IHRoYXQgd2FzIHRy
aW1tZWQ6DQo+ID4NCj4gPiArICBhZGksc3BpLW1vZGU6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGVudW06IFswLCAxLCAy
LCAzLCA0XQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgU2VsZWN0cyB0aGUg
QURDIG9wZXJhdGluZyBtb2RlOg0KPiA+ICsgICAgICAgIDAgLSBDTlYgQ2xvY2sgTW9kZTogRXh0
ZXJuYWwgUFdNIGRyaXZlcyBDTlYgcGluLCBzYW1wbGVzIGF0IFBXTSByYXRlLg0KPiA+ICsgICAg
ICAgIDEgLSBDTlYgQnVyc3QgTW9kZTogUFdNIHRyaWdnZXJzIGJ1cnN0IGN5Y2xlcywgaW50ZXJu
YWwgb3NjaWxsYXRvcg0KPiA+ICsgICAgICAgICAgICBkcml2ZXMgY29udmVyc2lvbnMgd2l0aGlu
IGVhY2ggYnVyc3QuDQo+ID4gKyAgICAgICAgMiAtIEF1dG9ub21vdXMgTW9kZTogSW50ZXJuYWwg
b3NjaWxsYXRvciBkcml2ZXMgY29udmVyc2lvbnMsIHNvZnR3YXJlDQo+ID4gKyAgICAgICAgICAg
IHN0YXJ0cy9zdG9wcyB2aWEgcmVnaXN0ZXIgd3JpdGUuDQo+ID4gKyAgICAgICAgMyAtIFNQSSBC
dXJzdCBNb2RlOiBTaW1pbGFyIHRvIEF1dG9ub21vdXMgTW9kZSBidXQgb3B0aW1pemVkIGZvcg0K
PiA+ICsgICAgICAgICAgICBTUEkgYnVyc3QgcmVhZHMuDQo+ID4gKyAgICAgICAgNCAtIE1hbnVh
bCBNb2RlOiBDTlYgaXMgZGlyZWN0bHkgdGllZCB0byBTUEkgQ1MuIEVhY2ggU1BJIHRyYW5zZmVy
DQo+ID4gKyAgICAgICAgICAgIHRyaWdnZXJzIGEgY29udmVyc2lvbiBhbmQgcmV0dXJucyBwcmV2
aW91cyByZXN1bHQgKHBpcGVsaW5lZCkuDQo+ID4NCj4gPg0KPiA+IEl0IHNvdW5kcyBsaWtlIHRo
ZXJlIGFyZSAzIHdheXMgdGhhdCB0aGUgQ05WIHBpbiBjb3VsZCBiZSB3aXJlZCB1cDoNCj4gPg0K
PiA+IDEuIFdpcmVkIHRvIFBXTQ0KPiA+IDIuIE5vdCBjb25uZWN0ZWQNCj4gPiAzLiBXaXJlZCB0
byBDUw0KPiA+DQo+ID4gT24gc29tZSBvdGhlciBjaGlwcyB3ZSd2ZSBzZWVuIHdoZXJlIENOViBj
b3VsZCBiZSB3aXJlZCB1cCBkaWZmZXJlbnQgd2F5cywNCj4gPiAibm90IGNvbm5lY3RlZCIgd2Fz
IG5vdCBhbiBvcHRpb24uIEluIHRob3NlIGNhc2VzLCB3ZSBjb3VsZCBpbmZlciB0aGF0IGlmDQo+
ID4gdGhhdCBubyBvdGhlciBwcm9wZXJ0aWVzIGluZGljYXRlZCB3aGF0IENOViB3YXMgY29ubmVj
dGVkIHRvLCB0aGVuIHdlIHdvdWxkDQo+ID4gYXNzdW1lIENOViB3YXMgY29ubmVjdGVkIHRvIFNQ
SSBDUy4NCj4gPg0KPiA+IEluIHRoaXMgY2FzZSwgaWYgIm5vdCBjb25uZWN0ZWQiIGlzIGFuIG9w
dGlvbiwgd2UgbWlnaHQgbmVlZCBhIGJvb2wvZmxhZw0KPiA+IHByb3BlcnR5IGFkaSxjbnYtaXMt
Y3MgdG8gZGVzY3JpYmUgdGhhdCB0aGUgQ05WIHBpbiBpcyB3aXJlZCB0byB0aGUgQ1MgcGluLg0K
PiA+IEFuZCB3ZSBhbHJlYWR5IGhhdmUgdGhlIHB3bXMgcHJvcGVydHkgdG8ga25vdyB3aGVuIENO
ViBpcyBjb25uZWN0ZWQgdG8gYQ0KPiA+IFBXTS4NCj4gPg0KPiA+DQo+ID4gPiBQbGVhc2UgbGV0
IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzIGJlZm9yZSBhZGRyZXNzaW5nIHRoZSBvdGhl
cg0KPiA+ID4gQ29tbWVudHMgYW5kIHByZXBhcmluZyBvdGhlciBwYXRjaGVzLg0KPiA+ID4NCj4g
PiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IFJhZHUNCj4gPiA+DQoNCg==

