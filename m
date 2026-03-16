Return-Path: <linux-pwm+bounces-8276-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOApKD0muGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8276-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:48:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BCE29CBA9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 521AD302853B
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054583A256B;
	Mon, 16 Mar 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AF84xobg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAD246BC6;
	Mon, 16 Mar 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676062; cv=fail; b=lQuAeSISFuRp+2UcK728+SJtKR80BnOzCAza+q9/knjcZbTjfXKmbWeQhAdtEDE9qjqITT5aOFSuxE/VFbbHg7DKa7IEGUE9rI/v9dMYj6otY5eAahEp10A3Wn7NY+cAGmq9VgwZjzJHVRH8PxWjvfLoB6t6TCE6O1KV5quThjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676062; c=relaxed/simple;
	bh=Ty+tkw/hhJQHn5uzaYTfPXgz0EobqzQtKg2NhKnd3yI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jsA6cxuPAYaR0l819gUTXwOSGQ9ppCpffkVNhFHZNCTlfB7pOsf2TcUcNnmv6UPoaGMBTMH9Z/LK8fD8KnGUcNEDg4+fFxsNeWNhH2z/nCax1XLpzzVL/eZoHYgyO80RLTI+5JTS4k6hYdg4OCL5GfBsmwwl+mjab5XTMB08zDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AF84xobg; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GAXXrS408314;
	Mon, 16 Mar 2026 11:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ty+tk
	w/hhJQHn5uzaYTfPXgz0EobqzQtKg2NhKnd3yI=; b=AF84xobgKOxose3uNcJvr
	Psn4IfNv6+Mq6Ak6lBdIGOUHs03nflfdouAsFwZyGOleum2qgLt0N2YgSBl9mg9a
	l2vrQrFP5UKqLypEf84q2bSMY2mXcghn3OaaKUeAgY5mvPBCzbF4tDANaUEs8Mac
	oDmUlwfBCO0ezyzZEFgQ3GaiTJLdDhsbeFXVaodYsuHVt4bLZsz4qhMCSFKW1pNG
	Oi+g38lG0Qgip4KDEEj/O7EhGy39Hk2n3Epvx7ecmM6o1uf9WZVur1cNU7pWZa0R
	dOE6GU7ztITUHgHEBB56x4hgveGoTXIE0kucrgPxF73CVoNDIi2yhp9jyoROGRLy
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1e5pa3h-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:47:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+MITOp+pIqj/a25CCB8iJqtdARdaV3yIRVqD5WzUi0yYH+V2UtF99Kx1rhaO4/rSqd4ea+eRuyFlOW+zT+w50moKaV5LYAhEj5Sm/FeovNhKK5NrCYNKJxm6gKAmsGLTheiq3ybSLfy3+z5Wx4x84kucTFrSrIbDeND2M3DeySovVlksGqDrIgKOSJEd6XC2tEt73vPYBuSKJB9+2THU7JIrUjc4s06ZCtLFqtKQNyaL8UjExdZGwPNTNgZei5b5nb5fnNMC5rvqrzm364IwGhd8p571IbnwfZoOm/Tgdvwq1F1O1G5rcrdAY70VjaBCEwMNtek/3rl3LoCAUOY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty+tkw/hhJQHn5uzaYTfPXgz0EobqzQtKg2NhKnd3yI=;
 b=A0QHr14ge7RGiC2Uo+ei5q4//EULAsH4umcTJKZzRIQfndz3ZUOcbihbQMUBBRXdll+Q6rVsJGR6gxwuanQXA8ad/sP7hZ7QzTqV/MUiCgqcSCbXmUSPJv18nk2lvXG55Algk6UYa5EJd8MPIpYP6Vyq/s5qnPpsu8kSNJvJsbbkWyaFWH69LZNo/17aNvrJ4krifhjnPq/GhnhysvD4rXXYQdrIyCZhdCcXlL8+G7nvxTKkrP5RM15N1+4D4AR5CqFaHbFsGO/OAjsyrSO8ECHUwoZICPsrvpU5AMfh51uBFvvfVLgTHEDdt5Eprhtk4iMDpDtrr29NgvAfSwASxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA6PR03MB7880.namprd03.prod.outlook.com (2603:10b6:806:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 15:47:01 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 15:47:19 +0000
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
Subject: RE: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Topic: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Index: AQHcstE/ku+BrpeHyk25hycFu2yGm7WuKSYAgALtptCAADK5AIAAB6fw
Date: Mon, 16 Mar 2026 15:47:18 +0000
Message-ID:
 <LV9PR03MB84144709474363AF7BBD2BA0F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
 <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
 <LV9PR03MB84149CBDC5DD03EDAF554136F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <04257601-5ea2-4cd8-8170-29decad13861@baylibre.com>
In-Reply-To: <04257601-5ea2-4cd8-8170-29decad13861@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA6PR03MB7880:EE_
x-ms-office365-filtering-correlation-id: 959808ca-2c61-485e-d4ee-08de83734e3a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 ViRLHmhU0D5GIpDP9K3kxcIdBQ1ga6bkIDAPMUKz9hGbi/95neQwIY3RWLwXLI6tO3T5p5utZp8EdvLpKVU2RwFbodkwwQ3yp/4caBH2o2SHVSxsUnRJGSR5ArgbS0KtVX2CCypJjlkmj3cG6a8Tk24V6FjYI/8EC4r6orAI30bpCZliiZ92fBBKma6kk7VGR/cMm4kiyjhkP55Pdo5NCrD5dGzaLXshQdPRjittStjpwI+dRUTmkrfybNSLI5P+BJj0qgU2JwfDP+8eyHjsU2e2vvbu/GBbJ9ZMj9ujW/A9szVTbCG+Um+Gj2nfn3xEJtRdbgcHlUHbnoU7tGUrWEQlI8QI6VjvQNRVlifG99sQZn9E384SjsMPcX+BrPcWg7quuJ4NLlXhAizfolOI450uAMGkdLlTcuveQ8zpTQhfA8AxqDRivYVoOkkcex6MNCYwd1LMTkfdTRrrPyVcouU/y7qHXjyV8MrqL8LphYcxzNtRpifHxOOijpna5Zo4+Q7vp4fwkXN4sP7+Ctizm8PlfWAjq+VOI4I6hdEeys9dR1mPmIkTist57fxURGzLv5BpmpLvNIwh2355NYjddOscr4RxK7NthivsCypiK45oJQVnbyDq/Dxp5JjYudjWtHU0Aq5DcRTvrwM27YvADhNsCaTkvxSGN6SWbNT3Ybtwike1GY4toz7nFbqoN/o65d8qJVNB/DEAdmE/MBlGz1bPrIlIn8rHvLpSDzsVvoHc7CopMXHZLPllOtr5Y5Ei1MH7qNqVBfsCIZ073WelaVC6f4bmGew1IhDmcUJOPDoQdXuRxD/7S6AnwZzkRepo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWYxS2VzeEg1a0hvV0Q3MEZRZ2svaDRreDRNREVyVmgwbGhBVTJvcHl6TXF6?=
 =?utf-8?B?VXJLTE5oUXFhZGwwZ0g5TGE5T1dHRkM4azh6dmZUMXNVdGNUS1F6T1lSWFQy?=
 =?utf-8?B?N1BQWEJNYnFGOFN0RjhpMVdXSmRvY2kxb3VNYzk2WlUrbVgyd3V2V0dFdXY2?=
 =?utf-8?B?Wk1YQ3hTSURBdjh6eE9EU1FNRHVid1hYQTAzQ2d6N3dkU1A5RHpVU1daSURo?=
 =?utf-8?B?VjNsMmVDQk04Z28ydmt6VVdETTJsZnpncFhDbW1zc25ZaktFRytXSktHVDlR?=
 =?utf-8?B?RWhvcjFBM1N1eFpabUROeXFaanRBUklxcytPaXRHcVVua1VBWDkyTDc3WnVm?=
 =?utf-8?B?UGZCRGNnWHFUbVEzMzdVNjgza0RldjdBaGRjN1NzSzlCQ2dSWnZ0azMrdTlt?=
 =?utf-8?B?eWN3YnNJbmxTL0NMcUtrYkVUOG53OUpBRlVadVREdGpjSHAvdXlpYXUvVG5S?=
 =?utf-8?B?NVlsNFdjZ251U1psV2dvTWZvK0kwdzJacklMcFFabXJtWEx2Sk9sbGE5UzdK?=
 =?utf-8?B?Ty8vVmZTaGVmUSs0VDA4RkVBTGxsV05lZHB4UVlVQ3B6clNsd2x4K1RENWtG?=
 =?utf-8?B?STB3YWhLeVFWQnRNRG1WTmJPdEF5MllYbDNhNTQweVFzVEZYQnR3S0dOZVcy?=
 =?utf-8?B?elB3K2JOeFVNRHBmTGUzZ3RVOUQ1NlVhVFJRdDYzM0FTa1R1U1FDNHZaY1Js?=
 =?utf-8?B?QVk2VmZqTThnVzlpcXJPM29FS2g1RGtHS1JwRGcvalEyNisrSmRpbjE5TURp?=
 =?utf-8?B?YnlPd1BBYWZZaklVVlhiOHB4V3hKZjFzWnNieWJZRWNCdHhsM3RiOWRqMmhw?=
 =?utf-8?B?QzZGeTZCNUozSXczdTkzRTljYTJRTnFaS0E3Q1VBbDZvU094R04yMldqSWgr?=
 =?utf-8?B?d2cyZ1JDZXJDdzdhYm1zWkFGNVlwem5oWWNaVEI3eTFZUE4rNkViWnZiemYy?=
 =?utf-8?B?OHBUeTgxU3ZHSEJIVDhLZVV6c3dlVmtGTFhYUTM0Vk9kM3VhQjZ6NjZoa1J2?=
 =?utf-8?B?RkJzVm1xM1YxNjUrRUtYbjUwTkFRWXpWTHFPaXlnaXNCOEsvQjBsYWFlTnR5?=
 =?utf-8?B?WFBQZjVwMm9ENTZLMUR5cExYL3ZYeFh6dCtqVURjbzRUVFNNWk9jL1pPejV3?=
 =?utf-8?B?Nkp1QmRNN2ppN3ZVR3AwQjF2V05NeEt6dkNMM2poUU4vSk12elMxZWdRV3Rz?=
 =?utf-8?B?QXg1eDJPWHVqRjM5cUpZUjBLd21QL1RTajVCdE1KZ25qZTlHb3krS3hXZUpG?=
 =?utf-8?B?d1lYazhrOEpBcWpWTExtaWcvY3h3NlovWEQxb0V4dFVRUHRwcHo4cklubnk5?=
 =?utf-8?B?c2FiY1AwVzhvTWNmYmpoWkRDZGJyU3FxUUFoNjNrbkZTZXBvN0dBbGVyOGox?=
 =?utf-8?B?QmJVbnMvakM2VXc5SkYvZmQyMUVwL2grVGpseUxnQmRUS3h0ODF0cnoxNi9W?=
 =?utf-8?B?MHg4cG5EeEU3N291WVlTdmd0TVFldXhsUVhyYTllc3FPdjZ2amVMTHFzUGZZ?=
 =?utf-8?B?ck9DQjNCNlU5OE9Ba3RVK2liMVlqYlA2aXNTMm5HVWFhdXo1VDZYenZObHo4?=
 =?utf-8?B?ekxtdHllcU9NY014RDJiK3B4K3Q2VVRZYkhEb3FZWTdSNENDcjZqSWNOWjlj?=
 =?utf-8?B?aFkyTUhOTGhDZW03eFRyUTZwZi9wVE9nYlk2ZjF6dTBkRzgrV0wyVmFRaUsv?=
 =?utf-8?B?UkFIelJUL1Nrbjl0Y3ZpUzRkYTQ0bmU0cWRVV3QzSEV4SHJmSW1ITUZBeWU2?=
 =?utf-8?B?QWlvL0tlSDZYcG5ialJQQjdyc3NZdGRGVFlTTWgyaTJkS0dZVXFaQnZzaElP?=
 =?utf-8?B?OG9vSll6N2ZxejBIM2FyaWNEbGQ3OGJMdmpFZUdFMkxRSHpSbmRCNitWc2R5?=
 =?utf-8?B?bS9TTDBWaFhOS3JHQldnekNqVWlpUVQveU00dC9FTDdtaEhUNXFpWHBlcm5S?=
 =?utf-8?B?WE56bU1FZHQrdjJ6b1pEVlBMdTh1a3g2TExWd203TmRNWnB5SG9xS21EZWdp?=
 =?utf-8?B?RTNScXFjeEh0Qlhuc3gzSnVVd0ZOUXAvY1dVY1F6b2pBVXplcloybnN5Wi80?=
 =?utf-8?B?TVovZ3RiaUhzZEJhSDRJNHhqanY0YjFQY28vUEFhTXJhenhWQWFYbXFRQ1l0?=
 =?utf-8?B?QlVDM0RaZjVCVDJVaVJzZmVpekUwYWpOTE9XVWc4TEt0T1RjZ0VGWHpHdnpX?=
 =?utf-8?B?V2JSV1pMOFBHSmd5WTFwRnAzczRQZFJXWmdrTWQzYXhmMEJKU3BCYlhFVXRt?=
 =?utf-8?B?VEZHb3FjWjB6YkFJRzRaYzZjeEc0Wk85di9Pb0lqeStEdTNvNjM4NEpOc2JT?=
 =?utf-8?Q?n+WsIepIRIoPM9rdDo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qoxWzBe73fRJC6JiynzI4uyNoz/HZAO9/FTg0eLplmkZeDPGrcIndVo2mN/VA8dO1iwlsi3M632aQUJE7JecZ0t3qSH/Z3C1zxFPLgwxEdwvJpsDIdmjcnE5QAvr+Kl2uAJTES5COteP99Ws6nJXWBWxHvSDyP2uEJbpA9d5X5Mu4k0JR6Ek0b2cCqIf1Cg6OVlZ3KDuxbIuPcHz/sQZZb71EcAbJurin51eGYdMuDsVMTiiwNuycCF0jBRs+CXtA+fxWQXB5PM6RudwopVDfzdtUt5hzJLoBtpqFpnIg0ZAoKDLCP20OaVPMXyMQ3yT0UQtYcpeoA9g6c1IIpipWg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959808ca-2c61-485e-d4ee-08de83734e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:47:18.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSD5nJHpeHO8v1R7Upl0LZsbXk88bqRe5AepaKKiwlIkSf52rzPEJEnvmwScbLsTT/sQMhndikttruNUQVFxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7880
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b8260b cx=c_pps
 a=HPJBkY93y09GhBhYB2jcmw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=IpJZQVW2AAAA:8 a=1SMxZOPfFQwd7Ig0myQA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: fr7F2ZiJVuudkWy_yPVgiOa2siAvHt-K
X-Proofpoint-ORIG-GUID: fr7F2ZiJVuudkWy_yPVgiOa2siAvHt-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyMCBTYWx0ZWRfX57oStWQpNK4b
 pRyNiJd9Y5FZZmdQzxwxFkLqwXVxzEnLHUFcovaSddP5XCwLGPn9UMOyhcjjwCEvqZaTv6FyMy6
 SFmWo4I6UFrNv8LM7wSLlQx5v6xMelJWX22c4z9UAJuuwRwvouLt0dL+JTpoZuapW/T0J1AuC1f
 Dxb+64gkdkkulLLOpy8KQtGkVdIM+2NEyO7C8STzSFctPRoGwi/VVkY4WwLbcfHwScQpMvWH/m1
 C2/e6mRWkWQORL1kC6CsR7V4YoemTFMLyugUT3c0sbA6IISayJKisE7M8LyLyZLj9SOdjpyAQHr
 fY+sqIFiz6wy06fuGWobBH3JrFmM5bm5E2SqO8Y5OzbTCAhbP7ydcrBYDEaLuIiFMAnavnkAv8w
 I1/1Nbg56vPgVqzgNrsahkNECsCgYwrpMdjAJWk7rxCSUAK7p1kKteckBZ7gC/J66JrS8lnhKB+
 TBYtw1yMjdXZCABaqmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160120
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8276-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 62BCE29CBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDU6
MTQgUE0NCg0KLi4uDQoNCj4gPiBJIGFncmVlIHdpdGggdGhpcywgc2luY2Ugb25seSBEQVRBX1JF
QURZIHdpbGwgYmUgdXNlZCBhbnl3YXkgYXMgYW4gaW50ZXJydXB0DQo+ID4gaW4gQ05WX0NMT0NL
IG1vZGUuDQo+ID4gSW4gZmFjdCwgSSBhbSBub3cgdGhpbmtpbmcgb2YgcmVtb3ZpbmcgQURDX0JV
U1kgZW50aXJlbHksIHNpbmNlIGl0cyB1c2VkIGluDQo+ID4ganVzdCB0d28gY2FzZXMsIHdoaWNo
IG5vbmUgb2YgdGhlbSBwZXJoYXBzIG1ha2Ugc2Vuc2UgOg0KPiA+DQo+ID4gMS4gTWFudWFsIE1v
ZGUsd2hlcmUgQURDX0JVU1kgaXMgc2VsZWN0ZWQgZm9yIEdQeCwgdGhvdWdoIGlzIG5vdCB1c2Vk
IGFzDQo+ID4gYW4gaW50ZXJydXB0IG9yICdmZWVkYmFjaycgb2YgYW55d2F5Lg0KPiA+IDIuIEF1
dG9ub21vdXMgTW9kZSwgd2hlcmUgaW4gdGhlb3J5IGl0IHdvdWxkIGJlIHVzZWQgdG8gc2VlIHdo
ZW4gZWFjaA0KPiA+IGNoYW5uZWwgd2FzIHNhbXBsZWQsIGJ1dCB0aGlzIG1vZGUgaXMgdXNlZCBm
b3IganVzdCBvbmNlIGNoYW5uZWwgc2luZ2xlDQo+ID4gc2hvdCByZWFkaW5nLCBzbyBhZ2Fpbiwg
bm90IGFjdHVhbGx5IHVzZWQuDQo+ID4NCj4gPiBUaGUgaW1wbGVtZW50YXRpb24gd291bGQgc2Vl
IHRoZSBlbnVtIHJlbW92ZWQgYW5kIGp1c3QgaW5pdGlhbGl6aW5nDQo+ID4gdGhlIEdQeCBwaW4g
dXNlZCBhcyBEQVRBIFJFQURZIHVzaW5nIGEgbWFjcm8uDQo+ID4NCj4gPiBXaGF0IGFyZSB5b3Vy
IHRob3VnaHRzIG9uIHRoaXM/DQo+IA0KPiANCj4gV2Ugc2hvdWxkIHRyeSB0byBjb25zaWRlciBl
dmVyeSByZWFzb25hYmxlIHBvc3NpYmxlIHdpcmluZyBzaXR1YXRpb24uDQo+IFRoZSBvbmx5IGNh
c2UgSSBjYW4gdGhpbmsgd2hlcmUgdGhlIGRldmljZXRyZWUgbWlnaHQgbmVlZCB0byBrbm93IHRo
ZQ0KPiByZXF1ZXN0ZWQgZnVuY3Rpb24gaW4gYWRkaXRpb24gdG8gd2hpY2ggcGluIGlzIGlmIHRo
ZSBwaW4gaXMgd2lyZWQgdG8NCj4gc29tZXRoaW5nIG5vdCBjb250cm9sbGVkIGJ5IExpbnV4LiBU
aGF0IGlzIGFuIG9kZCBlbm91Z2ggc2l0dWF0aW9uIHRob3VnaA0KPiB0aGF0IHdlIGNvdWxkIGRl
ZmVyIGNvbnNpZGVyaW5nIHRoYXQuIEkgdGhpbmsgd2UgY291bGQgYWRkIHN1cHBvcnQgZm9yIHN1
Y2gNCj4gYSB0aGluZyBsYXRlciBpZiB3ZSBuZWVkZWQgdG8gd2l0aG91dCBicmVha2luZyB0aGUg
ZXhpc3RpbmcgYmluZGluZ3MuDQo+IA0KPiBTbyBob3BlZnVsbHkgSSBhbSB0aGlua2luZyBjbGVh
cmx5IGVub3VnaCBhYm91dCB0aGlzIHRvIHNheSwgeWVzLCB3ZQ0KPiBzaG91bGQganVzdCBnbyB3
aXRoICN0cmlnZ2VyLXNvdXJjZS1jZWxscyA9IDwxPjsgd2hlcmUgdGhlIGNlbGwgaXMgdGhlDQo+
IEdQIHBpbiBudW1iZXIuDQo+IA0KDQpJIGFncmVlLiBUaGlzIHdpbGwgYmUgY292ZXJlZCBpbiB0
aGUgbmV4dCB2ZXJzaW9uIHRoZW4uDQoNCj4gPg0KPiA+Pg0KPiA+Pj4gKyAgICAgICAgLSBTZWNv
bmQgY2VsbDogR1BJTyBwaW4gbnVtYmVyIChvbmx5IDAgPSBHUDAgaXMgc3VwcG9ydGVkKQ0KDQou
Li4NCg0KPiA+DQo+ID4gSW4gdGhpcyBleGFtcGxlLCBJIHdvdWxkIHNheSB0aGlzIGlzIG5lZWRl
ZCBzaW5jZSB0aGUgQ05WIFBXTSBpcw0KPiA+IG5vdCBvbmx5IHN0YXJ0aW5nIHRoZSBjb252ZXJz
aW9uIG9uIHRoZSBBREMsIGJ1dCBhbHNvIGNvbnRyb2xsaW5nDQo+ID4gdGhlIHNhbXBsaW5nIHJh
dGUsIG1ha2luZyBjdXN0b20gc2FtcGxpbmcgcmF0ZXMgYXZhaWxhYmxlIGluDQo+ID4gY29tcGFy
aXNvbiB0byB0aGUgaW50ZXJuYWwgb3NjaWxsYXRvciB1c2VkIGJ5IEFVVE9OT01PVVMuDQo+IA0K
PiBUaGUgcG9pbnQgd2FzIHRvIGhhdmUgYW4gZXhhbXBsZSB0aGF0IHNob3dzIFNQSSBvZmZsb2Fk
IHVzYWdlLg0KPiBJIGFzc3VtZSB0aGlzIHdvdWxkIGJlIG1vcmUgY29tbW9uIHRoYXQgUFdNIHdp
dGhvdXQgU1BJIG9mZmxvYWQuDQo+IA0KDQpJbmRlZWQsIHRoaXMgbW9kZSB3b3VsZCBiZSBtb3Jl
IGNvbW1vbmx5IHVzZWQgd2l0aCBvZmZsb2FkLiBIb3dldmVyDQp0aGUgUFdNIHdvdWxkIGFsc28g
YmUgdXNlZCBhbHRob3VnaCBvZmZsb2FkIGlzIG5vdC4NCg0KPiA+DQo+ID4+PiArDQo+ID4+PiAr
ICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwxMiA0PjsNCj4gPg0KPiA+IEJlc3QgUmVnYXJkcywN
Cj4gPiBSYWR1DQoNCg==

