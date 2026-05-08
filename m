Return-Path: <linux-pwm+bounces-8846-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFL7OdvE/WkpigAAu9opvQ
	(envelope-from <linux-pwm+bounces-8846-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 13:11:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4831D4F582E
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F09300CBF6
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2026 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2335F179;
	Fri,  8 May 2026 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qIL5rjAI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860353128CA;
	Fri,  8 May 2026 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238560; cv=fail; b=TKWwxDTsL1dGqp7rTTuenH4xxeNPP+gYcPSGpMmw94prczlywEkMaNiY7rjRe3LVon3ypZhw/yEuFzy4E3cF2CF1g9TnhGxzy64oGwuixf2MgoZZ7P0tQ/cBftbs8I7wGayt6vG5fy9Gg8uNlaex9mTYquj2r7ytS02/OflCY4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238560; c=relaxed/simple;
	bh=ljdgZWI/0Ki+IGIQN8ZZ+J7CiuH+rf/Qy1aHjlaCRpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrJ+1stRWMOpYlyEWdf89li8+eiX/f3LHYycAm0xeb18Hs2GlGzvu4FCVztRu/+Wy+5ZVKzeIDPgl9dipwLDGFViWcFt/aoavQp/creUUsr/bOmVVeqpIpuemqsBqsVeAbBooZ9bE8/HhRwMDmGoct8h6v6FQeNx5FEnZ3oW2Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qIL5rjAI; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488vFI33611414;
	Fri, 8 May 2026 07:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ljdgZ
	WI/0Ki+IGIQN8ZZ+J7CiuH+rf/Qy1aHjlaCRpc=; b=qIL5rjAI6MJyBDfa3hslp
	+zQJcZs4idWkmPbWpC0mS7r2JaLPaqkNE3P7/0n4oGhUtsn+IudOGoXPiDoifgb7
	HS9090weSESu7JB4AKiG7Cfkxn2Pb4JIVBvj4VnjrGBQYSSMuiQEuwqm3lQdOcRY
	n5SFTtnMgTqLwbXWXbwZieytzkQwmUSk0Nn/v5dUYXE7tRS3A3dIhZ2V5SJsM6jS
	TSmJi78t9IcyCXCmLR9jIi/E7HO7LX7RXPe0rX+UHwJu823E24cCeN83WW7w2byH
	Mzf+cAYuTw/VK+1tJevYshs0Md6yiYFoyOMxb5CjoTN7txea2PZhI/lneyhF5JhP
	g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pjj1v6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:08:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ6poO42pg2o8XjUalbjA3nIsu1J88s5bIR/q/OgHSmsb9ZiL5hM5yU+TftDMkZbtqouiEG0k9/NOq/0QQRFs8LYLx6qaD1h1/SylvGR+EQtzFRW4dGSUlTztta00owwrSd9n2RvZpIJguAPKVy+Cu+UfMj0IA6WK5S8MIiph5sul6frdCxTf6z6n+63vUfoabhAgKaeJauDwHvH+aVRTt0smSRUgU8L5PhTXo7WREe/W/fSIvq5drqt8AZyYbVB5kzsoeXCvrOcH2sDQfn3gS7Ie55+PfCxw/U3CpEfzeYlIMmNS1xf9f2F04JCTLuFIWUclBTygCbnT7x62PehNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljdgZWI/0Ki+IGIQN8ZZ+J7CiuH+rf/Qy1aHjlaCRpc=;
 b=Lm+d6VzBrhoW4eDHmqy246rwIMvrIczPwbyG91uvKSKXtoNMYGnl3jvJlE+BGrsszoTHVg+TeWUFF/bJk5YloiaBZElVogmo+NnnF5k62ejVaxWaWfxbCa2hZg9g4IgVpco7enTONfLAgF343tj3XP4XHbmek4eF/cu/hwP1j96gpE2ciCWPy/CJUkw0v+3yGNNMjygX0IHPX6nUxMbAbXydEItHB3X6iif1/ckxM72tKozdiAlbQ96YaaHoKJY30KixqY0n1Rz74lNLATyxM5iW61jbfKWn3L98p2uApMpMHfLm9kGlknDn0oZn26uSwZCpC7ZlrDWaJbQVfBAvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 11:08:52 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 11:08:52 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
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
Subject: RE: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHc2Ip5b9xysBU1HEufEOvMimkIw7YCVfvwgABTqACAAVsH8A==
Date: Fri, 8 May 2026 11:08:52 +0000
Message-ID:
 <LV9PR03MB84142F5BB02ED75050A9F93DF73D2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
	<LV9PR03MB8414E0FFAD9C9423189117B2F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260507152532.09b385eb@jic23-huawei>
In-Reply-To: <20260507152532.09b385eb@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH2PR03MB5335:EE_
x-ms-office365-filtering-correlation-id: 30505743-6793-4ea3-0641-08deacf23055
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 0IO53iqWhChBX3a6diFzLKDqicTxFmPecsr3srMSpPaqYMLsvYnRNE2IUUU+Q0T3N2j2XTgAa9H0eG+2VkX9VUOBvc+PI4ImgUngqgTb5Q7W6I2Xr+bXCNadAnFgjJJvne5XPnNKdYjpA60IGcfU5xQTwKltN1WuxE9U0zKPfz9K8otymSRCkQJQJTb7tn1GGLx4HDjvhD4EdHsH+cZRvm9AFkIglyy4eEasJIoqfEwYekA5bgY0irTsykXwfFLRxO814E19RYzJgOIL1R3ZcnZFYpN/EVRmSEq8hB0W+ZLm8fP9B7c6YTbkLtD6XSjJ4IWtiQBF764tqawGPVA+Z7m6KwHbm2SF4+1I9rYQy+ipCMgzqdgayZX4/nKRNhG+6pRhVZ0fOvkBU1k5PD3hgSU0zf/nTEbXT1IPiPKIZswH2BiZykkY0rrPO+0Ieqg1mkC6UI5ife3vGJgqE87wrzwgtGwXo+YY/vlrfQ3YEQ2gXJv6EaSi4Up50TtDURZVO2b3LFSUPNsRx46VXn/+qKsboVSVBqIeT/w5qMnGZftInt4WSU8j+eNjR+O9leH82BkGCacNQNZtmYaO5icWhgQh5skhavxk5f+/C47w/37kt5IWzX84GDt8zwm4yk9d4j9FSYql7bUs/8TN3Hhu60h6z3WiHVHVllh1EmYYLq0IuDMnTyqZw6soAP1uu4k01iKhEnHuWJ66vRFMHBV3X1Pb7iUOTPClXNWvQjW4dOLYfPNO7uHNVo+JU9mdmfOy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHVWOGNkQVNsQVY3VmgvWVhsUTEzenJEZ2lwZWtkMjVrUnN5eG1oYytLL1Fx?=
 =?utf-8?B?K0hXbFQ3MUxIRnVDdUZuOER0SE9JbW04NUo4OXUrcWk5UzVxckJNdG41UkFL?=
 =?utf-8?B?cldkMTJxaXRlUk0rWExHOXBQcFlROTBtTHQ2bUR6L3BQbFNVTS9KTTJEQ1Bj?=
 =?utf-8?B?ZnVvbi9Pd1lkaFFZQVB5aDZaSzJrRDVEZ044ckFZSU5nZnpOR2ZGSmpING1N?=
 =?utf-8?B?MEJITG9sVFJDOGxWZmdYNCt1Yk8rbkRJL2NISnY4VWRPNGtpQ2FXM3VNa0Rn?=
 =?utf-8?B?bVA0WFZMOS9pZ0dLV0ZmVXRIQjhXVzV6NjdhZmRIZXlQS2VwRG1oT2NHRmU4?=
 =?utf-8?B?WHFIZVNGN1YyWHltUXJ4VlVYNkk3TU5YTnJaU09tMDU1ZDYwVWZldEpKbzFS?=
 =?utf-8?B?VjlvMG01S29LMTE5ZVh1aWk2TG96YjhkS2hPcnlVK1djYUlsNE9QcVRHZlBr?=
 =?utf-8?B?VlZvNXBJL0hMcE13bTRrMlY2ZE5WTUZjczZmdjlsSXlJd1Qybkt5YWZLaWFz?=
 =?utf-8?B?OFpMK0VhNC9FMVVveUtlMjNQL2dGaitLZEZ3VEFZQnQ5VG92NVMrYXpXM2Fm?=
 =?utf-8?B?L29SdTQ4Y1FwaFZ1bDdwWk1yU09JTThwWVFpQUZ3VmtGZFp4M210NXpNTysy?=
 =?utf-8?B?dFpoaG9NbkVtMmtXSUgwcDdzZWhWeXVWd2NWMTQ2K2NTcTM4QlJrYzk5RFZk?=
 =?utf-8?B?NWhuK2x4djE0ZkN3NjJRQi9RalVhZWNuSjgwR2oyOHBNVTFOOUtZVVZsKzg2?=
 =?utf-8?B?Q29QaEw4blVXd3ZRb3FtTDJIVS9TUEFzOXpuOGM4VXE0dDlkaXJycDhwUUFN?=
 =?utf-8?B?dmZna1BXVEpxL0dOaGN3T2ZLSEU4WXRwaFFtQk9KN0c0TE1CcWR2OXMrS0sz?=
 =?utf-8?B?c3dSelpxVjhZR21iWkZwZER2eTlMTFk0TzA5UDNxWDhjYXJ3dG4vcXF3b0kv?=
 =?utf-8?B?RGwvdWwwS3pYQkJibVJ2OFZyTUY4ek10eUNQNlBuL0J3V1NaWHIrYXgxalQz?=
 =?utf-8?B?Y09MY2poZytUbU00MGgrU0tyb0h5VTAySFhkWlVaUDhNMVNTOHdrcXdlRFBR?=
 =?utf-8?B?SmZqUEpvMVFwSjNGQTBrR0NMTnE3VitwWmU1RG5SRzkwd1lucGxJbWhOaEwy?=
 =?utf-8?B?cVpZZ2tLR1hQajEzT2JSR1UzbUZpMUl6YkNCR0hWc2dweG05NXczTjIyU2hJ?=
 =?utf-8?B?Qjl6WlVkQWFEZDN0b2tSS2RDWkVtVUtyMis2WUl0SG9JLzRsdUUwdXFzVVhX?=
 =?utf-8?B?WTZvcUtYZkE2SW9tOTRoYktMUDBQTVhzYTZTaGNJR25MeURjbXlFWSs3RDNy?=
 =?utf-8?B?R0hCbnlQZ09nY3I3OVFEbXROcDNVZ01QTk1mcHZ6b1hEOWxrS2VzUlFQTWY2?=
 =?utf-8?B?UXV0Zm15ekxkVHFKeFdQQUR5aVBnekNKOG52KzdnMk5KL0lySnJmcVB1U3c0?=
 =?utf-8?B?WHBrMWNyUEtMMXdra0o4dmhEWjdWbXF0Y0JqcEJZQ2NhRjYyMld5MlNYMWRX?=
 =?utf-8?B?U3Vnb2c4MlFpUWFRbXdHclRDSjlaTENERUd6aXJhQitCbFJoNGJCTEY0Sk1s?=
 =?utf-8?B?c1ptRFBmT3BBSGpYT0NEWXNFVEM4NGlBRXlCMDZBSk9uNUlUK1g5dWVsTGR0?=
 =?utf-8?B?TkYySE1XaW5PbEk2SjVoZmVoWUZWbnZUd3ZMVUV5dVlkL0NoWWR3YnFYbGlD?=
 =?utf-8?B?N1U0c0ljOSt5S0QrZHhJdFZxSjF6WTBIOU9aK0gwQ2ZUN0djb00zVllYYjBy?=
 =?utf-8?B?NWVvbFZNLzV3ZmFhTE1wOEo0c1FxbTNDSTNxNU9abDFLVG04YnkzTjVKdmdl?=
 =?utf-8?B?bUhkMmZuWXpneUVtRHdCTzVJakp2ZTVuaERnUTgxdTZBWnprTmtBdFAzcVN5?=
 =?utf-8?B?WkI4elo1NjVaOERIMGNwbHFoTUJlOU1lVjRkdXlaeWlsemJ0S2I5Wk9POUpv?=
 =?utf-8?B?MjBTeXhxQndobTEwVVlqZHFOUU81SENxc1c0aHBCSDZHTGRJeTkyR3FlUEMz?=
 =?utf-8?B?YUNPK0N6WUdGR3ZsWEJrcVRCeGZQYWgwMmgwNDlVV3BXa0R3MFIyMFZNUUR5?=
 =?utf-8?B?UDNmUjVoTVlRV2xheStka2JLSzNFdHNtK2hHVE00cFpDZHFKSGxPbkQ4K3dy?=
 =?utf-8?B?Yms4c2xtOEZqV3RpMVpQL1dvVE11RytiVVF5ckxMNkFhektkRU90RGp4QjNQ?=
 =?utf-8?B?Vzg5dEdLM1Eva1BxTk1GeVRPZlpnMXp5b3AyN3AwQnd1VHhtM3NVMFlobFJU?=
 =?utf-8?B?RlhyNVltUTE1amVycjNWRDZDNlVlb0R1bkpHYnYzdUt1STlKckZYK1ZrdnNz?=
 =?utf-8?B?Z1pTMmM5aFZoZVNhREFERXZLYmtnT2NtOU9aeUp6eFhEYjJSOVpnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	skLm7kLx5sTCE6hTbzaJ7oDY/vZTEVTmp2TAYStozSRgJpuloSqY/ZxJizZVYXIIHAXUmNATybLbqzv24kPR0T/xlvZ6R7JwXNB2lx1z+bdotBxUAi76WXp94xFzTQpgbwstZ4Bti1JZ/6YPGdaABhLLOrenN/NP4hNekz82WEqyKIXj7uTVb8HN9F0wRlX+EXzu1CqHi/XLYynIzUDuhOKH/323k3ZgMj+7Vh7jTYRUj+fL8Cu6DujPYhO7ag65tolwLWY8T35d23b6qPgLt/WaEQyYueLu7Qc75kg7XPr9pp6lZeE5HO9bANRbc+bD0gKo/ZH8UosM9kznMM0r5A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30505743-6793-4ea3-0641-08deacf23055
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 11:08:52.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+AypoKUx1F/+XSXbHXrOsMOZ4koR46KA724aC0IpvY/GkxeKvJbmRyAkaCszhFYVUFKKuMzMAXYzWtvppBqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExNSBTYWx0ZWRfX8qkNrfNG3u0r
 oEmTmI4nlqRkpO/P4BOI337LUelaVyjd389/bCkEnPelMgqxdPL+aLAOob+zMwEBVsjXlPctU+Z
 gFd873dqQWLj3uQfyJ6I4l5ydF3tKvridf1azIfCEIrftIOOhmVHDFUZioBJ1AZ4xtnhAQ9XTEH
 ZyNaCzVH7nScspgkJBQ6+ULbXAWC3AFzAJf6pkbs/3yW4lV/zkL1sL9KYmAzbD9MLFnj89WbVa1
 ARWUP/xViByFWo1neToRmQ4lltUNWbWu056ad3Ype/HtpXxRfhU4tfM3VLbsS4OD6WkAebza6M+
 Eztb2Vzbs1gqoDbKttqs4nUlRQpO2l300QTg94AncFT4W+iw9/R7jBImbZRcEm0w8ApyD5oeP3w
 yfFsuuZBLGO+fWKy6kY87qS9RL7/4W15VRjI23GCTgvMHihgz05nBii9ZYT7iDmr1VKuMtJvWNY
 3E5P4CxKmE0z+dPk9QQ==
X-Proofpoint-ORIG-GUID: CBHGpFxRaq1QkD0ydWivLroVY2voYA6o
X-Proofpoint-GUID: CBHGpFxRaq1QkD0ydWivLroVY2voYA6o
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fdc447 cx=c_pps
 a=kAM6CeFpMxeFc5AoNv8A9w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=-lVpb8iOfXX4uJvujAEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080115
X-Rspamd-Queue-Id: 4831D4F582E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8846-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV9PR03MB8414.namprd03.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjYgNToyNiBQTQ0K
DQouLi4NCg0KPiA+ID4gK3N0YXRpYyBpbnQgYWQ0NjkxX21hbnVhbF9idWZmZXJfcHJlZW5hYmxl
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgYWQ0
NjkxX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gPiArCXVuc2lnbmVkIGlu
dCBwcmV2X2ksIGssIGk7DQo+ID4gPiArCWJvb2wgZmlyc3Q7DQo+ID4gPiArCWludCByZXQ7DQo+
ID4gPiArDQo+ID4gPiArCW1lbXNldChzdC0+c2Nhbl94ZmVycywgMCwgc2l6ZW9mKHN0LT5zY2Fu
X3hmZXJzKSk7DQo+ID4gPiArCW1lbXNldChzdC0+c2Nhbl90eCwgMCwgc2l6ZW9mKHN0LT5zY2Fu
X3R4KSk7DQo+ID4gPiArDQo+ID4gPiArCXNwaV9tZXNzYWdlX2luaXQoJnN0LT5zY2FuX21zZyk7
DQo+ID4gPiArDQo+ID4gPiArCWZpcnN0ID0gdHJ1ZTsNCj4gPiA+ICsJcHJldl9pID0gMDsNCj4g
PiA+ICsJayA9IDA7DQo+ID4gPiArCWlpb19mb3JfZWFjaF9hY3RpdmVfY2hhbm5lbChpbmRpb19k
ZXYsIGkpIHsNCj4gPiA+ICsJCXN0LT5zY2FuX3R4W2tdID0gY3B1X3RvX2JlMTYoQUQ0NjkxX0FE
Q19DSEFOKGkpKTsNCj4gPiA+ICsJCXN0LT5zY2FuX3hmZXJzW2tdLnR4X2J1ZiA9ICZzdC0+c2Nh
bl90eFtrXTsNCj4gPiA+ICsJCS8qDQo+ID4gPiArCQkgKiBUaGUgcGlwZWxpbmUgbWVhbnMgeGZl
clswXSByZWNlaXZlcyB0aGUgcmVzaWR1YWwgZnJvbSB0aGUNCj4gPiA+ICsJCSAqIHByZXZpb3Vz
IHNlcXVlbmNlLCBub3QgYSB2YWxpZCBzYW1wbGUgZm9yIGNoYW5uZWwgaS4gUG9pbnQNCj4gPiA+
ICsJCSAqIGl0IGF0IHZhbHNbaV0gYW55d2F5OyB4ZmVyWzFdIChvciB0aGUgTk9PUCB3aGVuIG9u
bHkgb25lDQo+ID4gPiArCQkgKiBjaGFubmVsIGlzIGFjdGl2ZSkgd2lsbCBvdmVyd3JpdGUgdGhh
dCBzbG90IHdpdGggdGhlIHJlYWwNCj4gPiA+ICsJCSAqIHJlc3VsdCwgc28gbm8gc2VwYXJhdGUg
ZHVtbXkgYnVmZmVyIGlzIG5lZWRlZC4NCj4gPiA+ICsJCSAqLw0KPiA+ID4gKwkJaWYgKGZpcnN0
KSB7DQo+ID4gPiArCQkJc3QtPnNjYW5feGZlcnNba10ucnhfYnVmID0gJnN0LT52YWxzW2ldOw0K
PiA+ID4gKwkJCWZpcnN0ID0gZmFsc2U7DQo+ID4gPiArCQl9IGVsc2Ugew0KPiA+ID4gKwkJCXN0
LT5zY2FuX3hmZXJzW2tdLnJ4X2J1ZiA9ICZzdC0+dmFsc1twcmV2X2ldOw0KPiA+ID4gKwkJfQ0K
PiA+DQo+ID4NCj4gPiAiVGhlIElJTyBzdWJzeXN0ZW0gZXhwZWN0cyBkYXRhIHB1c2hlZCB0byB0
aGUgYnVmZmVyIHRvIGJlIGRlbnNlbHkgcGFja2VkDQo+ID4gYWNjb3JkaW5nIHRvIHRoZSBhY3Rp
dmUgY2hhbm5lbHMgaW4gdGhlIHNjYW4gbWFzay4NCj4gPiBJZiBvbmx5IGEgc3Vic2V0IG9mIGNo
YW5uZWxzIGFyZSBlbmFibGVkLCBkb2VzIGFzc2lnbmluZyB0aGUgcnhfYnVmIHBvaW50ZXINCj4g
PiBkaXJlY3RseSB0byBhYnNvbHV0ZSBhcnJheSBpbmRpY2VzIGF0ICZzdC0+dmFsc1tpXSBsZWF2
ZSBob2xlcyBpbiB0aGUgYnVmZmVyPw0KPiA+IFdoZW4gaWlvX3B1c2hfdG9fYnVmZmVyc193aXRo
X3RzKCkgaXMgY2FsbGVkLCB0aGlzIG1pZ2h0IGNhdXNlIGl0IHRvIHJlYWQNCj4gPiB1bmluaXRp
YWxpemVkIG1lbW9yeSBpbnN0ZWFkIG9mIHRoZSBleHBlY3RlZCBzYW1wbGVzLiINCj4gPg0KPiA+
IEkgd291bGQgc2F5IHRoZXJlIGlzIG5vIGNoYW5nZSBuZWVkZWQuIFdyaXRpbmcgdG8gJnN0LT52
YWxzW3NjYW5faW5kZXhdIGFuZA0KPiA+IHBhc3NpbmcgdGhlIGZ1bGwgYXJyYXkgdG8gaWlvX3B1
c2hfdG9fYnVmZmVyc193aXRoX3RzKCkgaXMgdGhlIHN0YW5kYXJkIElJTw0KPiBrZmlmbw0KPiA+
IHBhdHRlcm46IHRoZSBjb3JlIGRlbXVsdGlwbGV4ZXMgYnkgcmVhZGluZyBkYXRhW3NjYW5faW5k
ZXggKiBzdG9yYWdlYml0cy84XQ0KPiA+IGZvciBlYWNoIGFjdGl2ZSBjaGFubmVsOyBob2xlcyBh
dCBpbmFjdGl2ZSBpbmRpY2VzIGFyZSBzaWxlbnRseSBpZ25vcmVkLg0KPiA+IFRoZSBzYW1lIHBh
dHRlcm4gaXMgdXNlZCBpbiBhZDQ2OTUsIGFkX3NpZ21hX2RlbHRhLCBhbmQgb3RoZXJzLiBUaGUN
Cj4gPiBwaXBlbGluZSByZXNpZHVhbCBpbiB0aGUgZmlyc3QgbWFudWFsLW1vZGUgdHJhbnNmZXIg
aXMgb3ZlcndyaXR0ZW4gYnkgdGhlDQo+ID4gc3Vic2VxdWVudCB0cmFuc2ZlciBiZWZvcmUgdGhl
IHNjYW4gaXMgcHVzaGVkLCBhcyB0aGUgY29tbWVudCBleHBsYWlucy4NCj4gDQo+IFRoaXMgbG9v
a3Mgd3JvbmcgdG8gbWUuDQo+IA0KPiBXaGF0IGhvbGVzPyAgSWYgYXZhaWxhYmxlX3NjYW5fbWFz
a3MgaXMgc2V0IHdlIHdpbGwgZG8gYSBidW5jaCBvZg0KPiBkZW11eCB3b3JrIC0gYnV0IHRoZW4g
dGhpcyBjb2RlIHdvdWxkIHNlZSB0aGUgbWFzayBwaWNrZWQgZnJvbSB0aGF0DQo+IGxpc3QuIElm
IGl0J3Mgbm90IHRoZW4gdHlwaWNhbGx5IHdlIHdvbid0IChzdWJqZWN0IHRvIG11bHRpcGxlIGNv
bnN1bWVycw0KPiBmb3JjaW5nIGl0IC0gYnV0IHRoYXQgc3RpbGwgd29uJ3QgY2xvc2UgdXAgaG9s
ZXMgaGVyZSkuDQo+IA0KPiBJZiB0aGUgYWN0aXZlX3NjYW5fbWFzayA9PSB0aGUgb25lIHJlcXVl
c3RlZCwgdGhlcmUgaXMgbm8gZGVtdXggYXQgYWxsDQo+IGFuZCBJIHRoaW5rIHRoYXQncyB0aGUg
Y2FzZSBoZXJlIC0gdGhlIGNvZGUgcHVzaGVzIHRoZSBkYXRhIHBhc3NlZCBpbg0KPiBkaXJlY3Rs
eSB0byB0aGUga2ZpZm8uDQo+IA0KPiBQZXJoYXBzIGdpdmVuIGFuIGlsbHVzdHJhdGlvbiBvZiB3
aGF0IHRoZSBsYXlvdXQgb2YgcmVzdWx0aW5nIGRhdGENCj4gaXMgaWYgb25seSBldmVuIG51bWJl
cmVkIGNoYW5uZWxzIGFyZSBlbmFibGVkLg0KPiANCg0KQ29ycmVjdC4gc2Nhbl9ieXRlcyBpcyBh
IGRlbnNlIGNvdW50IChjaGFubmVscyAwLCAyLCA0IGFjdGl2ZSDihpIgMyDDlyAyID0gNg0KYnl0
ZXMpLiBXaXRoIHRoZSBvbGQgc3BhcnNlIGxheW91dCAocnhfYnVmID0gJnZhbHNbc2Nhbl9pbmRl
eF0pOg0KDQogIHZhbHNbMF0gPSBjaDAgcmVzdWx0ICAoY29ycmVjdCkNCiAgdmFsc1sxXSA9IGhv
bGUgKGluY29ycmVjdCkgIDwtIHVzZXJzcGFjZSByZWFkcyBhcyBjaDINCiAgdmFsc1syXSA9IGNo
MiByZXN1bHQgIChjb3JyZWN0KSAgPC11c2Vyc3BhY2UgcmVhZHMgYXMgY2g0DQoNCkZpeGVkIGJ5
IHVzaW5nIHRoZSBzbG90IGNvdW50ZXIgayBhcyB0aGUgcnhfYnVmIGluZGV4IHJhdGhlciB0aGFu
IHRoZSBjaGFubmVsDQppbmRleCBpLCBnaXZpbmcgYSBkZW5zZWx5IHBhY2tlZCB2YWxzW10uIElu
IG1hbnVhbCBtb2RlIHhmZXJba10gZGVsaXZlcnMgdGhlDQpwcmV2aW91cyBjaGFubmVsJ3MgcmVz
dWx0IChwaXBlbGluZWQpLCBzbyBzdWJzZXF1ZW50IHRyYW5zZmVycyB3cml0ZSBpbnRvDQp2YWxz
W2stMV07IHZhbHNbMF0gc2VydmVzIGFzIGEgdGhyb3dhd2F5IHNsb3QgZm9yIHRoZSBmaXJzdCB0
cmFuc2ZlcidzIGdhcmJhZ2UuDQoNCg==

