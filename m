Return-Path: <linux-pwm+bounces-8271-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLxOBO4HuGkWYQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8271-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:38:54 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6670B29A963
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C910C30B9175
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8055398916;
	Mon, 16 Mar 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hrmEiBBR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3A386569;
	Mon, 16 Mar 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667906; cv=fail; b=mu8LWXC80k2XgwSL6FH9aM5eL13o7ZuZseSmiaYGfXxeNSpNXkHj2wpqa5RxWcYaZRexo8/CPWPQUB9LIf1Y2P8KN42tkheZVfxYzTgjLeXuwyOJqy8KPtfU8Dqc6B8H3H7x9p9R9bKwIKcxyyvw0yThvCSRWqgRx8/leqNJ4ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667906; c=relaxed/simple;
	bh=vSDbMTeGsU01D0nFlTEBEDc8CHo8OgAKPzWstLp0lbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoKdHUGi5MRZRiqfx1IpzGmkTpWCYD2Os2pClF/kwKKTsLYMfvKKYQsqcXjp0ZxkKWNIl04eZ+4ItlraCvqKpIraJDBiaK9Jv2b757mkao4R5tYbWLUDGjHHK8pkIzMBuOQRVftzXnDNEyAr3Qof0klPM8JCbcGAElPUPmTo9fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hrmEiBBR; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GAdQHS2124103;
	Mon, 16 Mar 2026 09:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vSDbM
	TeGsU01D0nFlTEBEDc8CHo8OgAKPzWstLp0lbc=; b=hrmEiBBR5LaOhbAfyYIbG
	ZCB/geH+Kohr5IWzmNslscgrghR1nPNwJKvQnPPEnZtCNb2qD6bxJgKuX2PEUvLm
	bQOhfTbfnMlGjrFGgtR6pC59qsVDqrlRKHotcB/4eVox9mu/rJjg+6lSKgSRwHy/
	fVRiepVWgLO0TxVLmm+woIAsGRZBlbxC20QF8BL58iZztexWI7brDwy+v67i0tYo
	LxjPDEDm01bA03nIkt5UyGtm1C+I4YuDSblIKXmRF5QITeR+jL6ICFjEPXos9dlm
	pablElLWkeFOSL/WATRPGhw08V2OGiWH/BKnWv8Tr59EzEjncFK9x9QaRkmJ6H3C
	Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1h1fcmv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:31:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLu1sFeroMwuXx20GRQkxp1rlhvBW2qtbNDvZo04EfQWVZeS4/6CpDuTG2SJX7X+o/2aQRxPTPKMYyd/xhaPxTNgbTvb7FutYNgTv+xYvo0f5ScJZuwLdeTTTWTC9lKmOwgTpRvDZYQvyF68ZzfJQq8dzbQZ6Kq5vxRHlOxwkhhblG0zy+cZL0U+HBqdyGS2VKDePdpoun9+2m7pYfFGcodaajGECs/UGpcgJBsncHhuIpzy3NObiZqkIVOX50sQzjWJYflgpGjLfdbP8B8BTXuqzGgP5tEqW4eB5gl6oIYlDxR3p4FhGZU2HMehldKHgKgZ5D8RUFpbJlWENEAbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSDbMTeGsU01D0nFlTEBEDc8CHo8OgAKPzWstLp0lbc=;
 b=o7FyrjJJcPw7yRubSbVNMF4ZYthBgo1n33uhpXbiMaGw/KB8vyk9J5pZ0Z6WoAXEvkOWAXuD6pZSAzLHbKPC64V9t0QLaD1jdvvfN2hAzZfpwhUqz1j7yvCZxRVv+ix97psSj83rhtp+ZYKRXHFa08Ggk1ZhFB0AvP9DKMHEVr+rPU7+yVcqdXtOgGEW78Fu3oICN2I0ktxJQYTAn+8YLP8jbPGQ8IZDFYC02ogvCLaOjCh4zx8TQ1bQUscd6eB8h9NB/+sprYrK3TTdj+CoFlLmryis96anpLxAQ2aQtaLruYDS/RtvmnnJTG23Bjx1STH8dQjduOHFRmefF+789g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA3PR03MB7417.namprd03.prod.outlook.com (2603:10b6:806:39e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Mon, 16 Mar
 2026 13:31:01 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 13:31:19 +0000
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
Subject: RE: [PATCH v3 4/4] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v3 4/4] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHcstE9uSuOfhfkuEiw+dJeOMhgGrWublCAgAK8HQA=
Date: Mon, 16 Mar 2026 13:31:19 +0000
Message-ID:
 <LV9PR03MB84148D2AD53C977D5EB92E14F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-4-b4d14d81a181@analog.com>
 <b8a9a56b-04cb-4bb3-8606-3d90d1aba721@baylibre.com>
In-Reply-To: <b8a9a56b-04cb-4bb3-8606-3d90d1aba721@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA3PR03MB7417:EE_
x-ms-office365-filtering-correlation-id: 50d54593-4c28-4875-f4f8-08de83604ea8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 6uQNTwl5SLP2O09u7EtVn+tmYhG6JMNTtygEnr9iyvAvihl+gupp087yXAIqe6t18IjEZhhDpCUfwhMvh6sq9v/Vxygj5AvLwGvFnrkXsKzM2v4eiKyrXftDoiHcETs7DtsW3rHspSm5U5hBxt+N2n+iAiydLiXgNWjrRVBt99bkLMP4U5S52bq/Dt6u2KljX9+A31Gf1pLQ/ioCD1vnqP+xjrffNhOCERyR7BcDP1FO/RgNu27hVqkuOq4XEEpCmb+3wcG8EAxzyey8h4aD93TDMtEZWIbwppRl2DMZ/dozscLM2YIzU1pJMwjsfWoFPnOlf3JDWkFN10EPduod/m0jFUCDyK7Khasst+5GChXgO8IXeS92hxQqp8IuJmwxE6UBziS/w8R7XNNPL5HT5t0V+gRxLL7fbHZan6ZWEb0JdvLAsPgt6/le+i7IK/pZR2JVT59JCWMx9QjPe/OFMJqarR7SaagVwHaDUcNQD4bHz/2q5TNgnxQ5dxuiu7j/5UOBUfDVZ6m/lWwh3fIUH9ZmVgM5gsqb5Z2UchvvjWO1FZlIyeBG0+NtQ2CM6xh/jHng3sh5clk3N54Ly8+X+dZeNhCAyIBDfzOeJPTXaSZAcKHb553FkadK6ckX3efKW/ytFUwrhaoJi5IlsYOf9lq7pqVnHjLLmISTZJwc6XLUR2s+EbiXpWwUwehP8zq7RD48+tV5j+/K9cLvXNjJu3oRCWLyoofyBmXStaWarIa+ibv+4MNV+Sint9tEk2/TIqKR3lVHvWPAYfnezRSg+redR0ZmjwL6a5SNjuJH/BY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K29qKzRHZjB5eVd1VTBMU1ZWem9xUmo1S0p2bFN4MWxYTmVBRE5CMHRkNWJm?=
 =?utf-8?B?RXlHdFhaaVhablBxKzdkWlBtMVYxMWpWQjIraERFWkVQWGljQ1FMdkJSUXJZ?=
 =?utf-8?B?Q0lhQTFlak5lVjVJZzhnaXh6SmdTOEhyaExzSWhTMEgvYzZtbTZRWEFIUEYy?=
 =?utf-8?B?ZmUvNFcrb2c3UGU2VTJCNkxQK1Y0UWFCajhlVkFHZzFqUUhYTkQwVmpVWDRj?=
 =?utf-8?B?VWMxWE1vQ2NwajllMGFVb0NiNkFKNTdUOG1xdXU4Q1VXRi8wckc1OXp5U2lt?=
 =?utf-8?B?YUdrdEYxUFZYUkt5eU1aWkw2TFQybVhVRUs1dlZiV3Bhak1NcjgwYXh0S1Mz?=
 =?utf-8?B?UkxnbGRPdVBnRml2SDUvemJOQktzdG9qcmJmTkRwaS9IWG5icVg5dlllSFgv?=
 =?utf-8?B?LzBuTkZ2c0QrU3NrVk9jN1BmdG84Z2ZuUmJyWDM4UVVVM05xeGhBTytYVDFW?=
 =?utf-8?B?YmRhdW03UEVJeXM3aWJvRWJldGN1NEdyQnh4Wm9zS1Fya2drMEpxZjBrSGIx?=
 =?utf-8?B?V0U4Y0F3NG42c3hlSEJ2SXRYK0RQRDB5aG5ITWJsaXgzVlBJL283R2djUHBV?=
 =?utf-8?B?eWR5K2txeFpaazFPemVhOUpXMEh6RTkyVUc5Unl2ZUZBSk9ISEhRYUF4ajND?=
 =?utf-8?B?bFZXeDdmc0lRWitySjQyMXZobkFFOUljQnM0N3NubmFCY0V1RG5LNXJYT2E2?=
 =?utf-8?B?SHRWYkIvQ0pjSzNnWHp3dXhlcG5xMTBqZGd5VW4vczU0MC80MTQreXRFYXE2?=
 =?utf-8?B?b0hvWjR4NnozODJoc0lKMzBXT24zZGsxOGNMTjRvUDhiWWl5ZnZMRGRhUzEy?=
 =?utf-8?B?ekM3RkZkWit3ZE0vNVhNaTdsTGZ1U3ZoYjBsYzRmTmkxbmpXL1h0V2hJN0Zh?=
 =?utf-8?B?d0VZek94NW5Lenhld29tQlUxTjJoV2YrS3VKeVNJTEJLZUpnUDg4dzJabXNS?=
 =?utf-8?B?RVJWa1JhSUh4MTNnY2pQNTkrSzY0NnJUeDVpOTZKRFQ2eExFektxQVgzd2da?=
 =?utf-8?B?eWVMVDhncUV1OE9Td2xtK3Mrd00vay9nVUVXT3lEQUNyMlF1Y3BYTUUxV3RJ?=
 =?utf-8?B?Y3ozU1QxbHlsU0lSVzdnRVkycUZZaThLSUdXWG1OQnh0Nll3azcyaUc3VE1X?=
 =?utf-8?B?aTJocFR5MzR5OWdSWVJ6Vk9rQWRXTnFTc3k1ZGphS1lYZkYxOHAyY0M4cHJV?=
 =?utf-8?B?bEY3Qm9Xdy9IeXIwZUxEVGJyTlhnTGZld0VGR0RFcVRxVDlXT0doanVOTTFV?=
 =?utf-8?B?SzJyakZsVW8yL2UzREJUeWRMalBLZllFYkU3VUl1RXdBK0doRy9UbFZPMks3?=
 =?utf-8?B?YXU0TGRCSy9TVDlCSjVEVVJSMnRMa3R5UTczdm1kMVQ3OWZTdVp2Z1JHS0Nn?=
 =?utf-8?B?ajJURU52TjVSdW5seTd5VkpVbHlINlNTS2NRT2s5WURBNmZYOHlaZit6U2c3?=
 =?utf-8?B?THVySVloZVkxUDloTWRBRjBNR3RHWTc4TG9iWllTcmlnUGtjUmI1K2hPVDdQ?=
 =?utf-8?B?SU1yTkZkTkJpNTlzZ0pFYlhLbzZPWFJjMjFBNHBUN2V3SEJQWE1yNXY2RVVa?=
 =?utf-8?B?Nnp3Wjd0Tys3SENFalJzZDRpM3ZOL2NuMEl1ZkZlbG5WRk93ZkhCYncxcS80?=
 =?utf-8?B?S0FMZlk5bG9BTE9lQUFuSmFhZGFEb3NjaE5Mb3JvaDZoaXoyZkJCcSt6UzJp?=
 =?utf-8?B?S2FSZ3JZR1NHYlJLNDduZGVSNDdySnA4aTIvVG9NMU1iSUtVK2owbkVOcE5q?=
 =?utf-8?B?ajlyOTAwSlg4d2RxS1lML3c2KzA1UEppN293RlZncDRYVk1Tdzd0WW5UTU5k?=
 =?utf-8?B?VHFuSkE4ajdNRWU1dVpBZlpXdDBJMG14WVZKWEtzR3kxVUM4QW03YUJwVnZR?=
 =?utf-8?B?U1pxMy9pVlNuMUZ6eUNReXRxYnR3NlpUZ2pLZUJxQ1VxR29EL3FZV2FFMmFY?=
 =?utf-8?B?bDVhcnl0T1pyWERkOW9YemFHSEJhakRRUmJnVlZvYUg4MjFGeHpFT0hpM1ZF?=
 =?utf-8?B?MDVxTnFRVVcwT1h0U2FWYllTSnMxQzdsbEptUCtQdWJseWVRaElyYkdmd2ND?=
 =?utf-8?B?UlZGcWdwNE5nMnZuTTRUY2dtblJPSWVUNlRwNDVqOGpmOUQyamQ1V2NYZ0Yv?=
 =?utf-8?B?M1liMEQ3TWlLVVNQOUtFWjBTR3VodnkxZDBkemdHUmFZZnJhaFBzTlpwWjk5?=
 =?utf-8?B?QVVKMDMwVTVYNzJTNnVIekdzV240YzY3cFRYejNaZXA0MEhnZDZubzJWTWxG?=
 =?utf-8?B?dUNMT001aDhYdERocG9FbFg5WW5UbnlEbkZRa0JPaEhTSHQzcG5RMFFUbGVx?=
 =?utf-8?B?OFJDQjQ5d0o5S3dSR2RveVRCM1ZjakdtM1RFRFVWQTNTa3AzZk5wZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OzS+6BVMfFIgKdY8QEYUiZ459/dBnqCPMN8sXBuLgG6Q59e4ishFujRxjnKQcaLPaFJHGePQTO5S4XgG4c/6kVFr48AEyLEQ4vY6IGMg5YRLKvXQrWwQSKTjRjKd7/BfS8sjIWuPPZAd1b4h1t9ABZlcGgWENJlH1KEkI46FtYk9KdkymKIP025vJEI02I7/JAWbBjmb7ARoTX8V2frChwUwpFx5xPduAjCLZG7SzEc5kEmeZ90CBgq6hQnYXVfaVm4QiRUqjRl30q0qDb7Dm/wWjA6a8GmCSz5wbQ3PVHT9W/ID2ooxPLKQ/va6DW3V/Q7SEfLlySzgGAlFNPXZQg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d54593-4c28-4875-f4f8-08de83604ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 13:31:19.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FPxOa/wmrDJPwdps709pBAp1KQKbQK5iKweHXJ9bgaW/2ACAaRRRhAQbkcFJwifrilL3pIS/YaIKn6hTVly3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7417
X-Proofpoint-ORIG-GUID: 8VFz4x68AdffYSwxrIkoS2USLrVIOyqz
X-Authority-Analysis: v=2.4 cv=FP8WBuos c=1 sm=1 tr=0 ts=69b8062c cx=c_pps
 a=y599upwrfiZ3HV94zaFOUg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=IpJZQVW2AAAA:8 a=7qYTfLHVzTD9EdYa01UA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 8VFz4x68AdffYSwxrIkoS2USLrVIOyqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMiBTYWx0ZWRfXxMlm4BR2KzEs
 F1yViDdDLF9ou2kPHiScMf63ExLbJI6OjZh3O2U94C+AUI/TMdfEBZXilLG8qxmPINICD4GIXxX
 r5xNUULZWEr5HNvAVBJ+azJL27ti27fsHKxz3kTn7KZjkpqsTbJPvFSFc1QHiH1KNEhIpXRCgH0
 f8Fgkp2d0nHcqTrcAt0RCBOJ0cyMAUUKS7/QYagIMCRQgvd55lEeD1TE/Rv2tEgSgi2agT1L3LS
 DfFH83CPSIUuTiBD8rLkB25gkpsN+5XAXTukB2W2+vJ9LU2TgFpdG/SnJZX/BZwBpyyf8zQSTfS
 qpt481vMy3KKyxiYSbp7RitBL2tWk5uJTbBtgFwoARVBlhqDwzBkeIQNIO4PyRXjaVGQ/ni9LZQ
 Xoy913vphH6tD4VfA/2aUQEURKHt0CU9oKEwXfn4ecas0QWq96ucL2DHNJzK3YVGTuVx0ZZyFqq
 wiKdYW+G4Hw9sZxALgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160102
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8271-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:dkim,baylibre.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6670B29A963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTQsIDIwMjYg
OTozNyBQTQ0KDQouLi4NCg0KPiA+ICsNCj4gPiArCWlmIChhcmdzWzBdICE9IEFENDY5MV9UUklH
R0VSX0VWRU5UX0JVU1kgJiYNCj4gPiArCSAgICBhcmdzWzBdICE9IEFENDY5MV9UUklHR0VSX0VW
RU5UX0RBVEFfUkVBRFkpDQo+IA0KPiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gQlVT
WSBhbmQgREFUQV9SRUFEWT8NCj4gDQoNClBlcmhhcHMgQlVTWSB3b24ndCBiZSB1c2VkIGF0IGFs
bCwgc2luY2UgaW5kZWVkIHRoaXMgcXVlc3Rpb24gZ290IG1lDQp0aGlua2luZyBvZiBpdHMgbmVj
ZXNzaXR5Lg0KDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsNCg0KLi4uDQoNCj4gPiArCQkJ
eGZlcltudW1feGZlcnNdLmNzX2NoYW5nZSA9IDE7DQo+ID4gKwkJCXhmZXJbbnVtX3hmZXJzXS5j
c19jaGFuZ2VfZGVsYXkudmFsdWUgPSAxMDAwOw0KPiANCj4gVGhpcyBuZWVkcyBhbiBleHBsYW50
aW9uIG9mIHdoZXJlIHRoZSBudW1iZXIgY29tZXMgZnJvbS4gSSB3b3VsZCBleHBlY3QNCj4gNDMw
IG5zDQo+IGJhc2VkIG9uIG1heCB2YWx1ZSBvZiB0X0NPTlYgZnJvbSB0aGUgZGF0YXNoZWV0Lg0K
PiANCg0KWW91IGFyZSByaWdodCBhYm91dCB0aGlzLiBJIHdhcyBwbGF5aW5nIHdpdGggdGhpcyB2
YWx1ZSBhdCB0ZXN0aW5nIGFuZA0KRm9yZ290IHRvIGNoYW5nZSBpdCBiYWNrLCBteSBiYWQuLi4N
Cg0KPiA+ICsJCQl4ZmVyW251bV94ZmVyc10uY3NfY2hhbmdlX2RlbGF5LnVuaXQgPQ0KDQouLi4N
Cg0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIENOVl9DTE9DS19NT0RFOiBz
aW5nbGUgdHJhbnNmZXIgcGVyIGNoYW5uZWwgKDItYnl0ZSBjbWQNCj4gKw0KPiA+ICsJCSAqIDIt
Ynl0ZSBkYXRhID0gNCBieXRlcywgb25lIDMyLWJpdCBTUEkgRW5naW5lIERNQSB3b3JkKS4NCj4g
PiArCQkgKiBBVkdfSU4gcmVnaXN0ZXJzIGFyZSB1c2VkOyBSWCBsYXlvdXQ6IFtjbWRfaGksIGNt
ZF9sbywNCj4gZF9oaSwgZF9sb10NCj4gDQo+IFRoZXNlIGNvbW1lbnRzIGFyZSBjb25mdXNpbmcu
IFdoYXQgaXQgYWN0dWFsbHkgYXBwZWFycyB3ZSBhcmUgZG9pbmcgaXMNCj4gZG9pbmcgYSAxNi1i
aXQgd3JpdGUgYW5kIHRoZW4gYSAxNi1iaXQgcmVhZC4gSSBhc3N1bWUgd2UgYXJlIGRvaW5nIGl0
DQo+IHVzaW5nIDMyLWJpdCB3b3JkcyBmb3IgZWZmaWNpbnkgc28gdGhhdCB3ZSBvbmx5IGhhdmUg
MS8yIG9mIHRoZSBudW1iZXINCj4gb2YgeGZlcnMgcmVxdWlyZWQgdG8gZG8gaXQgc2VwYXJhdGVs
eS4NCj4gDQo+IFRYIGxheW91dDogW2NtZF9oaSwgY21kX2xvLCBpZ25vcmUsIGlnbm9yZV0NCj4g
UlggbGF5b3V0OiBbaWdub3JlLCBpZ25vcmUsIGRhdGFfaGksIGRhdGFfbG9dDQo+IA0KDQpJIHdp
bGwgbWFrZSBzdXJlIHRvIHVwZGF0ZSB0aGUgY29tbWVudCBhcyB5b3UgYXJlIHNheWluZyBoZXJl
LCBzaW5jZQ0KVFggYW5kIFJYIHNob3VsZCBiZSBleHBsYWluZWQgc2VwYXJhdGVseS4gSGF2aW5n
IHRoZW0gYm90aCBhcw0KJ1JYIGxheW91dCcgaXMgYSBtaXN0YWtlLg0KDQo+IA0KPiA+ICsJCSAq
Lw0KPiA+ICsJCWZvciAoaSA9IDA7IGkgPCBuX2FjdGl2ZTsgaSsrKSB7DQo+ID4gKwkJCXVuc2ln
bmVkIGludCByZWc7DQo+ID4gKwkJCWludCBjaCA9IGFjdGl2ZV9jaGFuc1tpXTsNCj4gPiArDQo+
ID4gKwkJCXJlZyA9IEFENDY5MV9BVkdfSU4oY2gpOw0KPiA+ICsNCj4gCXB1dF91bmFsaWduZWRf
YmUzMihGSUVMRF9QUkVQKEFENDY5MV9NU0dfQUREUl9ISSwgKHJlZyA+PiA4KQ0KPiB8IDB4ODAp
IHwNCj4gDQo+IE1peGluZyBGSUVMRF9QUkVQKCkgYW5kIGJpdCBvcHMgbG9va3Mgd3JvbmcuDQoN
CldpbGwgc3RpY2sgdG8gYml0IG9wcyBpbiB0aGlzIGNhc2UsIHRoZW4uDQoNCg==

