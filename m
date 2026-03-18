Return-Path: <linux-pwm+bounces-8292-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF6cCtguummCSgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8292-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2026 05:49:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825222B5D0F
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2026 05:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CF13014665
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2026 04:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB162DF155;
	Wed, 18 Mar 2026 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NC3BzHG8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58FD2DB7AE;
	Wed, 18 Mar 2026 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773809365; cv=fail; b=stn1kPDGnPKLfUChSy/dP0bdp67lNwJ82U+8iupuh4CsY/D2IL1Pp/pD8vqkUUXD2zF9oCWBwik0PiQq4FqlK+xGtqseTIMqDKz7owwojCMxH3I2EIS1n6YD3odfa2r4wg2nBYeyPdFByc7BL9hPBLzElDEvFLHeGVusza0w1Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773809365; c=relaxed/simple;
	bh=+q4A9qq5l4t6M0OWD5ovvKgo7EBhM2QkDG9o/EsZuCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W6YxlW6TR/rlW1h/HsAUYdUN61jUQ0ZKSzMAXO6iqWPdJcT1zpUmBBSMTlNtSTFncxjEukDVZIVHZC5vFejJ0NfehuwSCT/o5H+E7p+mQKckZAtCUdKKuF90V91LGbKVS4vMMbeUWlm0mFl2GNNQUpgEdE5n7ut8KPAKnbTkwqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NC3BzHG8; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I4eWft1059857;
	Wed, 18 Mar 2026 00:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+q4A9
	qq5l4t6M0OWD5ovvKgo7EBhM2QkDG9o/EsZuCM=; b=NC3BzHG8v22tHQjt3896D
	JCpKxetXVXhanmiEYO4UDKsI8n7UoVYosWhj2N12LwjLgt3hSAmwY4VfXjxqE/Vf
	4BUbj9hWe4hOfIBHirMPQ0AphcPANl5YLwm8OsyKKFpjHzudXEBCpQpsBS2hHxPM
	irQyogye7kedfpMSdnuh0upjfJd25/Hlh+JE4Jtpn6ZR8GgGEIfFlLZNxKI7nq3p
	p3tJ8/vVPWk4YRTCk9MnEKxgWY1l7s8sncZMzsUytriisXhiHAiYRHLxHWZnbpty
	EyQUrNZBMQLJmPR6tYRljytaodYUFMraMtlaK0+H/Oqa2kv37bCO+P60U93YowOL
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cwsqfaj3n-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 00:49:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es53yvdfGyAUXNtNbgoO43V/Vwef5YKXxuNFYUuEkC5Gj2iABA0GnuMAO5QeyZCTgaLCjKvLycY+tcuZn+iwKwo3Q45F0dMDWGtWCPwMPy1aXszJCfyo3QaGRoid8Wz+HTMNNGJ769+0XSGUS6geQ9p7uCMELee8l5kOy/DF5KPb3Cvs5q0ni29XNiZQYPl9J+wzfu0NfCZUZCMbz6tFQRi3ZArz6QjRLX7iR7jhAN+pKledwd7LkjECk210mJ4WAGS6S2QO6qs84+YW78zPxigB5Ei46fAHhumogtIbnTRcqx+iDLVW6p/A1hVDnoo3lvBCUEqBYx5DML8KCh34bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q4A9qq5l4t6M0OWD5ovvKgo7EBhM2QkDG9o/EsZuCM=;
 b=vg7XW3ABWT36/UGGRLjsKQRoQk6Pp2s8SJWQMCI284oy76MJNqiShOF/PpadYW6TXoDAPdXhOb/2nCckEqw+i0O3P/OBndnUIBjrebzSWDcP0s5vtp1aFVpLyp0Dva9ztb9o3nbe3vuZAKqSU6QP6qa7LHglYnBj8UzKdvWkkzj57COYDlWk1uDnlb5gfDGjxrrQibYA594ph4PIeblmGjLxdirt7juEcPkb0EGmhTvNK1P7N/EheET8S24VhIgBdX+P/CVk3cB8ehu7R7giATA9B1qyNHmTqmx1wQB218B0f9/oBCsohri8h1K3oqIeWv3F1uwIfNUNO6lp9Ib0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by DM6PR03MB5001.namprd03.prod.outlook.com (2603:10b6:5:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Wed, 18 Mar
 2026 04:48:57 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 04:48:57 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] Add support for AD5706R DAC
Thread-Topic: [PATCH v2 0/3] Add support for AD5706R DAC
Thread-Index: AQHcsO1SoLl96C3nyUW6il5EtlPiSLWsN5GAgAeJ7oA=
Date: Wed, 18 Mar 2026 04:48:56 +0000
Message-ID:
 <PH0PR03MB635118F0208EECCFB399C846F14EA@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
 <abPZ79S_ME8p6s9V@monoceros>
In-Reply-To: <abPZ79S_ME8p6s9V@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|DM6PR03MB5001:EE_
x-ms-office365-filtering-correlation-id: ed4ea30a-c0fd-4b2d-e3ae-08de84a9aa1b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Z7VKXRogU3g3gPLxRqw2/huxfCoT0s1OUeXj1ZZgSfN4TRsGcd8tPmHsm6yWN9j4DCxvp5eExsytoJ4O1NcEqI/iRC/GrZZC4rWMYSBryRnJnmY2EBwYZtAgb48sCqyoGmSkxrgRkB7chF1E/K5AR/pjPxf+FFr/fItElV7ZxSSzFoZJSsDpNUcD5+R8TlfvO2yhOVlJbx8Og3w+HXHOL4by7BcX313gOe+Np27Qi46GzIjnN1jSkTaInr/2Zm+mFFdb3qARYhNV1xRPL4vH3piGPH71qEif6w3SYjnQH2ZqojlzbrSDD5i2kr+E8Yuzqqv5ZqAeJ9gzMfQYo0hZ+juEXSCJpJcGg6wY73gWumpUzcnFZFW/W0/op2BRtEGOqkopZr5a0OaEEF7iO2KFDIV7KdFOJqh5hyvyEOG8MQV7PhBv8mtV8ZRJtCJMeaJYkgcEXTF+RY4M8ouJR1iCZd1f+hiQ5RfQQg+p4EISfBM6S+6Q8vXZHpRyO2oLKi1L+wLZwwYzOfzNSeaitRVcsrXW2OxtNazfLR09LWOrHZx78BWo7bWhVBjyycNA2dEJuyqae+O+DCZ8S8pqyQ8RYR4DnNfns1oaiQ+GApCJs/PNDQdAU+dU42SISzzR0aZE2Wbddk3uRcB8Z4882za2iLLkiizsOgEXpDNfmUACqOcaND92haudhp3o9BBIS1szOXygMbBYqmzuwB/LL1ZA01/NcQI0/aXTC9gmfAe6ZRefoOPEdlrnlOZLIjhbLeEc3KN/Pqf3I0fRo9hCwJbv/+PCeNIYXnR0HXVf4wP8PrA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OIjrRm6i0C76vaa1+J5STAurJLTfrhBVG5nC8DuFogcTarppDFs9Qs4dG9?=
 =?iso-8859-1?Q?jDVm/bV+3u1V8YHjhpXv96DyDAOXB8VN++GiJd8k7Y6Rf/H9QFi7TYHMQ3?=
 =?iso-8859-1?Q?wCvvQnsyKBTFZY+ju0JiWOM4zfGJcVPk3hmQeWnX2/WtWULm6UJOr16017?=
 =?iso-8859-1?Q?Iud4nuX7HG3Y4G+pHkh2yn4oSWRw0d7bl/oP1zMoDDBNMbYRlbmlj71bGr?=
 =?iso-8859-1?Q?QRprwih81VpbbAfj/7LIF5Biggmp39GPAgFi50ZcNSSNzh8fwuJGrtGI+G?=
 =?iso-8859-1?Q?BnisgDfcKNY/ZezuBSBNGnWBUT3YlflTQIPaBAR5NQ3ObFGCWZh3U2f2Si?=
 =?iso-8859-1?Q?MCxlh7WReawoY8iQCM1PTfeRnRFYkCqeq5u1ECpEilAXUJVTeYWoHEBiWj?=
 =?iso-8859-1?Q?CgHYkD3sy5vFfq89HLc1VXDm0An1gvu4jTxeCN3YBsvGz2Ye79eXxubfms?=
 =?iso-8859-1?Q?9ZS5iHuPcyMRiYb6L3aT/QSoryW3HFhJyjDI7AnkTMeqJytbREknYIpx/l?=
 =?iso-8859-1?Q?8D50nCainXGboybbIjPBjs2bzfHaub4N3KKue2WWH1dqrB04w+qGFX4Rtm?=
 =?iso-8859-1?Q?2rExr0EiREbOUuIqoUTVn6eVmeDwsIRhraydQUqIFi1693kc150sKHmTq0?=
 =?iso-8859-1?Q?CsDAsZThbUcdJlV4u3L3HJoHYtkMiTANXzc+L04iYhpPVQTPekToIbI1oU?=
 =?iso-8859-1?Q?l7ticUwoos/ldstK77GwMTnQAd/ByLjOC1VZZjiI+gcE5ZhS4cT+bnvX5W?=
 =?iso-8859-1?Q?gvRA9bkhBIJHv4gjvRNbJVaEVX6Zvb57wtdrNFzBSR7mf9D2axbUfnPhWQ?=
 =?iso-8859-1?Q?IKZcfoqogwNLKjgxLXq+do1ARO8jPj4Dtg27aL+cZQo/6Ehfm0ugTwXeZt?=
 =?iso-8859-1?Q?LoRcNbhjRB9imxKwAx0MQXKTwb6Vik9CLA1RH1lvnmk2WaQNXtCnnh0TZR?=
 =?iso-8859-1?Q?jj44BZeiwHj2qAavmaDn1iOo1bnWmz/0xnoZ4LZFnBAOgutIHDfSQbASzS?=
 =?iso-8859-1?Q?PrRxs2NEjmvOMHo1LXmf1bLbEvAkmor3HBDadmZfnDF+83UCTncJUwuujY?=
 =?iso-8859-1?Q?ydwIfgMyeLK74uJ9nBT8RoZ5uuanXrE4gWrPW6AC92KJLYIiS7X0IBt+3/?=
 =?iso-8859-1?Q?RkjB6pOgEfvFV1iIOTJPsa1lOCznxu12TfhA3rBwbj2u/D2KtNdKHtD4ME?=
 =?iso-8859-1?Q?UuIWFErYnRMBNgQdhaZ65Y3bmRSDnyVJxvwT02bIV0Dy7l8Okk2UeC8YXB?=
 =?iso-8859-1?Q?A3v2pmfgLlgHItU2ESFguRUECTKMM4wq7bZNusi4uyPmVgqu5F6QAxBC/P?=
 =?iso-8859-1?Q?oaYoywMcF8po2oMpF9yXdCLMtASg3AgEI+PRRDRIsAS+sxGy1MY6SbenYu?=
 =?iso-8859-1?Q?MkNG89JAn6SFf18CI9BxWQbkc5mW+5Cg2YKfmIhFnxwwfsNq1r1X2NTwqd?=
 =?iso-8859-1?Q?p/hKdONMLJdmByDPud1wBaRubXDEZZ7RJ2E8IiLg5pAcIHFZ0QxfjpVLMV?=
 =?iso-8859-1?Q?tXXwmFq3/LsCqWxBSPV/pLBy7HwPhXs0GirF5NFgoIEC7xXO2gfLmsx/d7?=
 =?iso-8859-1?Q?F+9mUY4LVlxpXrnmAInOajiI7uXlhNuoee8rFubYle7te7HKPc8clrtXIO?=
 =?iso-8859-1?Q?o+Kl9oCTEHxqNXMomKlV1Z3X+nyrRGWQvPVrPvqC7UGjsb+WW5STEiuwkb?=
 =?iso-8859-1?Q?4h3G1bnyqpRV/s/JJQaMrvPEDUQk/qr0S3aOoB21wpm1gPPhDvYkdMkGZd?=
 =?iso-8859-1?Q?t1kj8/ORX2zAnYnmjHcMRHa9l97DGFQYPgZ8OStMUQ6F707S+ufD0amBZj?=
 =?iso-8859-1?Q?fEeUnURliD4RlappZ9oUgirxtVbQGGU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fB5rFwoQnDtQGSAegnvS8jM0iPO6tdBPGToHGrT+hH64kY/FT2cdMjdKv7Y8evnE5FUVnbsUyy/c53HRXgLugl0DLtzHvGB1wFA4Ww6ecHU1fh/RVRYX9AEaGTt1Ta0id0w+gkEFg1B30w4nSCgtL84Rrn+cGb7RYeA2mAZ7DYlk1YBqDZ0rRSfxyH+iXiLuHoIqENS743ZY5GI5P8+BUtf5cBsuzUEcbonUiWzbs/Jxn7pyIMHQLzvrID6Rst82quKbRyrQiyLCv+qT1D4KcJ70fRXxv3+KjSZapPOpBEImNLiXns5jSqnQHDqpbN1ECYpBKAYCVR0b5r/Dpcxesg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4ea30a-c0fd-4b2d-e3ae-08de84a9aa1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 04:48:57.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rmwnESyxHlqgIPklJiMPdWPyA8Rc0YB4Jqbpz+druxmCBWxDA7mYpKF6VY3HHjI+3yTejH2HYqazao0QgpHwid80zJtjPX7J4SCRuEaxV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5001
X-Authority-Analysis: v=2.4 cv=Y7P1cxeN c=1 sm=1 tr=0 ts=69ba2ebc cx=c_pps
 a=jJxBgQE0Gv9vBhouG1T1Tg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=gAnH3GRIAAAA:8 a=V1RA83Wjjwktlx44kvcA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: XGouiwv3WEPj2fP1Jxn61HLJGPeHldh_
X-Proofpoint-ORIG-GUID: XGouiwv3WEPj2fP1Jxn61HLJGPeHldh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAzOCBTYWx0ZWRfX7Vsj8SLvF9hf
 L9lZr5V6f/AGRmthQbwqOIYY9wdjnAre3NNVa18PzwTYH0IhbHOveSF/CNo5s00ZoGZL1v8AH+v
 fF73RjLkiP5rqyjaF6M1lLTvc7nEze4AUrNAh056FeThRfwAQFq8cWra6VqprbJIrsA3bdcgssb
 sZbbDgDyexXt/Pfn0kjNfT+bRRMleB5zjj5HTzKvAXN08hK3u7hU3SLdz8YLQ1XHVNn9CSia0T7
 m5YakFkI7ryfwoy3MQOuAJUgigLnDg2A6WhNPys6vhVOHlrnPrkswcY4oH5cvYha/3F1oPF+4Q6
 AStqrgBzTKjf0B/bkz1oFVKDuIDmkj7LwevonSJyZFH/LOS/e8sxI9RigRvyzm4jTQDg18AkE/K
 JXvlRO98v9KX5+4LtnSiJ+NBf9HV6Ms2b9TnVR+/PLRxRl4BXP4a6afSJhBzbH7f4ekkAFw8IWT
 9rzRYXb6jQQidJNuf+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180038
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8292-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[AlexisCzezar.Torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 825222B5D0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Hello,
>=20
> > This series adds support for the Analog Devices AD5706R, a 4-channel
> > 16-bit current output digital-to-analog converter with SPI interface.
> >
...
> >
> > Datasheet: https://www.analog.com/en/products/ad5706r.html
> >
> > Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
>=20
> This series was Cc:d to me an linux-pwm, however I don't spot any usage o=
f the
> pwm subsystem. If you still see some relevance for my feedback, please
> highlight what I'm missing here.
>=20
> Best regards
> Uwe

Hi Uwe,

Thank you for reviewing v1. I trimmed out PWM features in v2 but didn't
reorganize the cc list. I will remove you from v3 onwards.
I'll re-add you on future patches that applies the pwm again.

Thanks again,
Alexis

