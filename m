Return-Path: <linux-pwm+bounces-3821-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB49AE453
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 14:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBCE1F22E60
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E41C4A0E;
	Thu, 24 Oct 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UdEwOytg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685114B08E;
	Thu, 24 Oct 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771339; cv=fail; b=js1f76/L7080wPCoKpsDmlrJszX78bzIncRSzOUlol+MOwq/4puvp8DAsEokRvVTkdpGiVtsi0a2o9XURHij/HCfURi59XXQbWkxP9A1PR2o3JvKXdnBYMs1e8+iQOBuJ1MLHzWW2to8fKfg2oilr67sq/ZuA1P2Exlm5DCGYag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771339; c=relaxed/simple;
	bh=MiYEYrO1F/n37jTtOoSJQ3ZBSmiqQDudBtWTkF4V82I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ccG40J7qunfStowj8+DB6ePK3AF8GE34x57juL7ZiRDJRCcg0vmRmByfnFlA5+d647+snN3JQX1ZLTuxWcFqCocXVhNuYRVyPrO2gn1XJICG2p93yED2Q6FQBdpVmuuBlU1sr2R78h/i0h5DbcvQDaIE1THcbrx/yWjvqVQcdhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UdEwOytg; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O6OXx8014123;
	Thu, 24 Oct 2024 07:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MiYEY
	rO1F/n37jTtOoSJQ3ZBSmiqQDudBtWTkF4V82I=; b=UdEwOytgCS7jy5FGXR7vM
	pwsHbPecPUqLKK9lpDbinJZV+/kU7CuY9PZo6VuCt3+EHDb1dZXJbp1htfBsWESN
	Cz/LI6N+aWDTkobU8rj7LRdzdFTgyN5QEqKUFEsOPUnnZVTT0WnhPG/N0HQQGPXv
	v14Shyq25W/i3cjBuS4T5fPaFQnXZXghCmkziADJdt0SQGVSVS8FPQ/4+zBWBbZw
	Vjlo9bBgr0hWT1Nm/emR4JuUAGxcFTei7W9tkl8Gkcs2eka/OtnruEzfJ7+t5k/R
	65S6MmYUuraXax4oQYjqaK1T5qSfF+9+ZmrCNf2d55umcNrDSkk23hykUm+2ATfg
	w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013062.outbound.protection.outlook.com [40.93.20.62])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42fgxnh56q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 07:17:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDvfpBBAY0HFH6ojd3seUxVhbofygKpbR8Ic1mF3RWRF1o2G5HUOzAq6FhFT4jOhmYEGmHftacG+q/zYVFtyTTHpPSV7j/fK3WrCVoKfeXZl+rxi8zfGn2/wa25p6fs6SNzLr01VDHXK9oD6PeCkpkfR0RN1lXSUTCAp4pVIfyTPUtRav89Mt5G/2NyB14wx07LU06jeumxKZ4mldlMrQs7c1/yG4WalfbCnkw1x7Aou3Aa1YOHPrxfz7e85+Au/cNgxNnj4BP1Kp0o6xQobj2ZgUdInkc3WyQhMNbebvsehoU3PAIge2+rh50EunQ5LtXjbMj3lPxYALhUM4hBqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiYEYrO1F/n37jTtOoSJQ3ZBSmiqQDudBtWTkF4V82I=;
 b=Z6HAhs+sLAXZZ/8AfYbOrJrDEvusvhtgyvy8w2372jjwXkxA0IMIE3KMiD+wmYrZMbVN4ONyg8Co71hWvzLedA6KDoxzAn1dGG3qsjiaftb7Yoy9MpmRAtm2uEy3kpm4OJw8yhrmaFDxM54DXip5dLUX7ZDc9Jq2wahnd4k9GZLeA0GC7WVPJ9CAHbKZv2q63iATddt2wJlHt3Dn0+9TZbrHtcH46hWhY5PlAPi4X6lncNsa+9FfLmbzEKUM6vk0knMerW0SY9mQZTbCICDSB11L5wyE7P7mJzzI7+RigrP/WUPnL9GiAY5aS2IykICIy2n31+AfPgsFGl0cJccjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5353.namprd03.prod.outlook.com (2603:10b6:5:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 11:17:05 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::1153:bbaa:df9a:188a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::1153:bbaa:df9a:188a%2]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:17:04 +0000
From: "Sa, Nuno" <Nuno.Sa@analog.com>
To: =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Trevor Gamblin <tgamblin@baylibre.com>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to
 3
Thread-Topic: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to
 3
Thread-Index: AQHbJf8mPTSlExqTA0qjv541w862aLKVwGLQ
Date: Thu, 24 Oct 2024 11:17:04 +0000
Message-ID:
 <SJ0PR03MB54697FA984191152C2E83FF2994E2@SJ0PR03MB5469.namprd03.prod.outlook.com>
References: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzV6WVZ4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRka01qQTFZMkprTFRreFpqa3RNVEZsWmkxaU9ETmhMV0pq?=
 =?utf-8?B?WmpFM01XTTBOVGc0TWx4aGJXVXRkR1Z6ZEZ3M1pESXdOV05pWmkwNU1XWTVM?=
 =?utf-8?B?VEV4WldZdFlqZ3pZUzFpWTJZeE56RmpORFU0T0RKaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJalF3TnpJaUlIUTlJakV6TXpjME1qUXlNakl4T1RFek1qZzNNaUlnYUQw?=
 =?utf-8?B?aVJWRnVXREpNV1dkM1NHTjJVa3RvVFd3MVMzQTRObFl5TDFSM1BTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSR2RFUVVGRVNXbzRWUzlDYVdKaVFWbFJUakV6ZHpWM1Rs?=
 =?utf-8?B?WkRhRUV6V0daRWJrRXhWVWxFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCVTJkSlFVRlBORUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRm1jSGxqVjJkQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVU4MFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlEwRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFVRkJRV2RCUVVGQlFVRkJR?=
 =?utf-8?B?VUY2WjBGQlFVRk5RVUZCUWs5QlFVRkJRVUZCUVVGSFJVRmFRVUp3UVVZNFFX?=
 =?utf-8?Q?N3QmxB?=
x-dg-rorf: true
x-dg-refone:
 R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0JtQUdFQWJBQnpBR1VBWHdCbUFHOEFjd0JwQUhRQWFRQjJBR1VBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURJQUFBQT0iLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5353:EE_
x-ms-office365-filtering-correlation-id: b614e9ca-a0a9-4df4-fb01-08dcf41d63e4
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXFSaktRRjlPdmxDVDMrcEpwSFVBMXFnaXd2dGFNS003N0IzYlJHNXl0Nm9v?=
 =?utf-8?B?MTlOVFExS0h1SGt3NUZMSVlWcGNtODVOS2VzOXVmOXdEc0J4bWNuZVl3cmtZ?=
 =?utf-8?B?UkI1UHRrN1pzb0g0WUtLYVQvOTZkWWVBZnBUbmtXV2tiZzN2enhDWU1zeWhx?=
 =?utf-8?B?Z0xwZVpEWUc3ZHZXVENTYUZqK2FvWUxneHlCNFBnVGl0ZFZJUmExS3M4dzF4?=
 =?utf-8?B?S1BzMzNldERxVnFBY3M1OXBSNnVnOEQ3alMxRm5rTWNOVnZHeHBScVk0L3la?=
 =?utf-8?B?WnVDY0JHZTJYcDY0OFlUdnkyaDcyL2o5ZlRsMTJVbE9pWlhjZkpoU2R2WG80?=
 =?utf-8?B?VnFyWHVGdkhNeHM5V1pjQzBDOTVqOVlNazRLSVpMTXNJb09NcnljSXBWSWFT?=
 =?utf-8?B?RGJLakFVNGFJZkFERXdaRFBqUDFWT0VNRVRoZDRHaU96V0dYSnp4ckxteEFX?=
 =?utf-8?B?Q29OUmxzdFhQOHV5WkR0eTdiUHpQRUZVZk43ajV6VWE0WVNmcWV0bW1Bc1E4?=
 =?utf-8?B?RnBTeHkxRXdCQ090Ymwyd25KV3NkSjl6aFNQWk5jZ3NZbjdqQUFNRWJrTGdu?=
 =?utf-8?B?ZGVrRDVTcFJlbnNPNitRUmxkN1hCMTRsU1lMNlZDSGlQMXJEYkhoTGRpQ2VC?=
 =?utf-8?B?S0MzL2xQUlliNkF4YTdtaU9KZi9JQzhaOGRyQXVUVVdXZDhVQWJJWVRZU1ha?=
 =?utf-8?B?RkpETmNsL2h3VlVvbXYrN3l0QThpNWZxM3dBREhZa1J6b3lpeW1hM2hRSlBi?=
 =?utf-8?B?c1M0MklZK0YvSkxBdVlBZGdkaEtlazQxU05oaXFtU3F3cXJnZDZZQklpRUky?=
 =?utf-8?B?K1NCUC95SU1jSUJXaDFZMlloVDM5T0ZnOU5BMmhWQ2hxWWtvTS9UMUFINm1L?=
 =?utf-8?B?S1A5OVdnNGNISGNlN09HR0EvUWtuVzJsT3ljbzNYNDdKRURIWGhHZWtMRTVS?=
 =?utf-8?B?VzJkeHp4K3F2SXJuMUI2S0pZQlNBaHV0Qy9lVUpMazdBTHdyRTVHcWFXRFJJ?=
 =?utf-8?B?TlJaWU4zRGtsVW5rVzNZYjdhUlBic0Y4NXhBV3JZOGt6SHY4N0kvY1NjT0Ri?=
 =?utf-8?B?SXpwUUxoT25jaURwdVQ5ZlVObk5mVi9wajhIMGJUWHc4WUdOWkpzK1c3MkUv?=
 =?utf-8?B?KzJ5Ny8yb2o4eEROU0c3ZlB0cEdiTi91OVBwR3kzdjI0bDJxMzZoTStld2Yr?=
 =?utf-8?B?YXc4QXJKS0JWSE4wOGNhSnlHR3pubGpWcFA0cFJtUks5T3VNbzYvaG1QOUZN?=
 =?utf-8?B?Y1hlVEQ2MWl2UkZUbTdib2YzMmlMZnJnaWlCWFBMWWtCTXUwVnArWkR3bUdY?=
 =?utf-8?B?WVhtK2lVVHJWYW5NcWxoTVFzcURQcmpRbU5KTmZJYTgya21ZNlpZalRTbDRY?=
 =?utf-8?B?eWV4UUVnaVpvVWQveUN3RUxwN1hVdURNZXVtd0FJRTRSUCs0WTdDMjZUZlZX?=
 =?utf-8?B?QURmMGFRWXJ6UnVKdGlkazdtaW9VbFJ6aGl2Rm5sZzVzdk5LWFFCV2dCUmhG?=
 =?utf-8?B?UmcyRUVLWHY3b3lKT1pwcEQyajFkS2duNmNaT0tmaWlITmUvRjBXUGkvSEZw?=
 =?utf-8?B?Wk44dEU1cEpkeWRDWU1PTGFsRFZObVFPNGk4YWIrY00wZnlmY3cvRS84UTJx?=
 =?utf-8?B?bWx3QVJmNDZBaWc0YnFubm9QUjVSTUhMTXA1OEs1alNVV0dXWHBYbHVPZlRP?=
 =?utf-8?B?ZnpOakd5cjlPSDFqRUpwYVp6SHdZdGVXbVVjWDZacDRtVFF3MUtEeXpuelBh?=
 =?utf-8?B?eWNVdVRXa1lYZzZqdzNVbFFHUFdUS3FQL1pMMHJxOEpoUkdBSndlOC9wSjV3?=
 =?utf-8?Q?r+MjpNfUEN1nsHXc/Ki8wwrWdtovo+k3ku890=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3ZuYTRLZ3JKUWY4eGNrY2xtSDBRT0hXNUkxaDJuSjlSNTVoYTdRUU1XV1U5?=
 =?utf-8?B?NTEwQzlaQ2g1dnd4QjQyQkEyWlU0Njc0b0VyQS9CSWpNQnQwbTdZMHUvemsw?=
 =?utf-8?B?YlVOUS9McXhaWmlrdVV6ZDAxQjI1WHJ1VERDcERFTENFZDc3cTBvTnpmdFJB?=
 =?utf-8?B?KzhhU2luOUM4dnNLOGxLVUl0RytSOHd3QklBY1lhV2k0bkxDUkNLV0NhRWZQ?=
 =?utf-8?B?TDJyVnhZbXJBQUZPdEdTL3IwYmxLTW1qbjFBT0wzbm9oYVVQS1pDRkNUOTF3?=
 =?utf-8?B?MmhLb0VxWG9FbFZmcitwdHdmS3ZNbEMzNHR3Zld5Tk1zQllnZFRyNWExM1h5?=
 =?utf-8?B?MHE3L2FQSmN4clF3UVBKRGxOQVZURFAyZmN6N1Z0TjMzMU5zN0l4SU0yUnhm?=
 =?utf-8?B?Q0t3bjQ5Ni9SYUV2bWU5QVZOcmliU2tpTGFoeS9UNEs1bjF0OGluRTNNVm5T?=
 =?utf-8?B?c1QyTEZHK0RpM3dqY3Z6ajBkb1dTOFNpT1JPeXZXa0phbk9hTDlwRjY3UVov?=
 =?utf-8?B?UU10Rk1qY0x6ODhEZ1Y2d2xTVDRyV1BJSWttQnNyN1RockVUeFkzcXliRmwr?=
 =?utf-8?B?ZmVVaGprdHVpNi9GNjMwNFdtK3k4bC9tTWo3VDFEcFI3anBmdHJnTHQ2N3hm?=
 =?utf-8?B?TkRXRjlKcE00ZC84YmEwaHBoUkdRTGJzdklBSXBLbE9ldGFXa3drQXAvZW5x?=
 =?utf-8?B?UmdOazZ2Rkw0a1JyQ3p6NXhlY0p2VmlpQkNkZGM0T2FHRE5FSFJhZERpRmRN?=
 =?utf-8?B?TGdYc3pvT0cxMHdzZ0o2aEFHVjN2SUgyZU9sNzhrb2tGZE5HOTdhTUp5NzZv?=
 =?utf-8?B?ZTlwbWhwY1MyemUzaE9pUzIwd3BTZC9LY3VwWmFUSkpocTN3SzMycmdIeW5L?=
 =?utf-8?B?YTR3a1B0QkNhVzRQT2VmMkxzRjh1R3U2dFIxVExhVEZCLzh3OEpRYzhiRTdk?=
 =?utf-8?B?SHUvWm1aZGlDK1dMSnlBSHRBUk1mTUY0dGFsUVpRbDdyN3ZMNWtyRjVyQnpq?=
 =?utf-8?B?WXdCYnJjT2V4SzRWYVQ5c3JXeWNkd2s5Z2lseXZHSktxOTd2ZmpRQ0dqNFJn?=
 =?utf-8?B?MDNYZ25CU2phWCtKVWV1TjVGS0w5WFVuOVdNUVRLbnRvQnBBRTdHTjhFc2Fz?=
 =?utf-8?B?UGVwQnR0NlBWcnliN0hHSytEMlk4UG5HUlN1WE5jVFVwcnFabTUwcXplcUpD?=
 =?utf-8?B?VHdUVXdBWEphbkplMnlmM2tzMXZXb0RHcTRNQ3dpZUJac0RyOS9oV1pvYVRW?=
 =?utf-8?B?QkhZU1cxNXR4dzUyd1VQUEJCMHF5c0FtVDBVVFc1WWg5RUFFZFNHQnlod3dR?=
 =?utf-8?B?S3BjQmZvTC9VY0MzYjViSTF4R0tXTXNkVVo4NjlyQzYvOXg1UWduZTJkMHBj?=
 =?utf-8?B?ZEhNL2dxVCtaWU5JMlFuQVVia2VKU09Xa3Nsek1qK1VjZmFVZHVOYTdKWS9x?=
 =?utf-8?B?QVJyTFd6TXNrWWhLYzVRc3Fob0pDRnlpQjlUZnovK1RGa1pIQk9WSlRaaVhE?=
 =?utf-8?B?aXY1V01OZVFmVFIzSnp3cFFKVWIzRkNVTUhnbmxJd3ZZdTJFNU5zV2hLMWZ6?=
 =?utf-8?B?d0lYQ1ZZdlFPMlhuRlZFZHhjQVBkY1h0YlRaanp2c1ZkSzAwL01vcVUrd1FC?=
 =?utf-8?B?bVNIWGJiL1Ivb2xWMm9UTGpkOEZvVVYzdnBNdEI0TmtLSWZkb3E0VksvM3JE?=
 =?utf-8?B?d2kzQVU3ZGZGVDVZcXFNemFXSmxTQ0IwR0JYM0drUXgzU0FZelVSWnJhK2Jv?=
 =?utf-8?B?T2F4Ny8rcjhNQlI4K1ZWN1RndWl0VnN0R1BLR3pKalk3Q0tiVVNBTkNvenFS?=
 =?utf-8?B?NkxvOFFBdVplYU9sbWlxbUt4VDBBakhvanRMQ0QyNllKMGNDNTF3RTFnYTBo?=
 =?utf-8?B?UENMUTE1czV4cHUzdlJNOUIzRW1uclcxVTRmRmVLLzIwNWtLUXhhVG5PVXNF?=
 =?utf-8?B?NkpGcTJhOTA0clNzMnV0V2pvRTdKRWJxNE9CbThOSGQ1bTNrOHJEbHRvNGh0?=
 =?utf-8?B?eXYzV3crdGViR3NRbmlRbmxwTW9qR05jZERSV21ldCtjQ1kyV2ErUGRuTTU2?=
 =?utf-8?B?akt1Q3RIbkhsV2tDV3YyWkI4RFFLODg0bGV0TnpUV2t4ck5Dblc2REN1d0lm?=
 =?utf-8?Q?Qu4MTP+Q60EPoV+Spbgs5oPra?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b614e9ca-a0a9-4df4-fb01-08dcf41d63e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 11:17:04.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6gJQr9FxMt2R1jgsYo+BQkUzkxQ5P9wP5dOkLd1SZgJn9SS6z0uh1LweMr6whBGcbzjkLBgHhrsm4fsCn6NgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5353
X-Proofpoint-ORIG-GUID: 7steE6WU3NmeLESROmm8VZFAKpl7e_7J
X-Proofpoint-GUID: 7steE6WU3NmeLESROmm8VZFAKpl7e_7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240092

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDI0LCAyMDI0IDEyOjI2IFBNDQo+IFRvOiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwu
SGVubmVyaWNoQGFuYWxvZy5jb20+OyBTYSwgTnVubw0KPiA8TnVuby5TYUBhbmFsb2cuY29tPjsg
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGty
emsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4g
Q2M6IFRyZXZvciBHYW1ibGluIDx0Z2FtYmxpbkBiYXlsaWJyZS5jb20+OyBsaW51eC1wd21Admdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb
UEFUQ0hdIGR0LWJpbmRpbmdzOiBwd206IGFkaSxheGktcHdtZ2VuOiBJbmNyZWFzZSAjcHdtLWNl
bGxzIHRvIDMNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IFVzaW5nIDMgY2VsbHMgYWxsb3dzIHRv
IHBhc3MgYWRkaXRpb25hbCBmbGFncyBhbmQgaXMgdGhlIG5vcm1hbA0KPiBhYnN0cmFjdGlvbiBm
b3IgbmV3IFBXTSBkZXNjcmlwdGlvbnMuIFRoZXJlIGFyZSBubyBkZXZpY2UgdHJlZXMgeWV0IHRv
DQo+IGFkYXB0IHRvIHRoaXMgY2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWlu
ZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpSZXZpZXdl
ZC1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0KDQo+IEhlbGxvLA0KPiANCj4gbWlz
c2VkIHRoYXQgZHVyaW5nIHJldmlldyBvZiB0aGF0IG5ldyBiaW5kaW5nLiBKdXN0IG5vdGljZWQg
dGhhdCBub3cNCj4gd2hlbiAoaW50ZXJuYWxseSkgcmV2aWV3aW5nIGEgbWFjaGluZSBkdCB1c2lu
ZyB0aGF0IGRldmljZS4NCj4gDQo+IFRoZXJlIGlzIG5vIG5lZWQgZm9yIGRyaXZlciBhZGFwdGlv
bnMsIHRoZSBwd20gY29yZSBoYW5kbGVzIGJvdGggY2FzZXMNCj4ganVzdCBmaW5lLg0KPiANCj4g
QmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiANCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wd20vYWRpLGF4aS1wd21nZW4ueWFtbCB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2FkaSxheGktcHdtZ2VuLnlhbWwNCj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2FkaSxheGktcHdtZ2VuLnlh
bWwNCj4gaW5kZXggZWM2MTE1ZDM3OTZiLi5hYTM1MjA5Zjc0Y2YgMTAwNjQ0DQo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYWRpLGF4aS1wd21nZW4ueWFtbA0K
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2FkaSxheGktcHdt
Z2VuLnlhbWwNCj4gQEAgLTI3LDcgKzI3LDcgQEAgcHJvcGVydGllczoNCj4gICAgICBtYXhJdGVt
czogMQ0KPiANCj4gICAgIiNwd20tY2VsbHMiOg0KPiAtICAgIGNvbnN0OiAyDQo+ICsgICAgY29u
c3Q6IDMNCj4gDQo+ICAgIGNsb2NrczoNCj4gICAgICBtYXhJdGVtczogMQ0KPiBAQCAtNDQsNSAr
NDQsNSBAQCBleGFtcGxlczoNCj4gICAgICAgICBjb21wYXRpYmxlID0gImFkaSxheGktcHdtZ2Vu
LTIuMDAuYSI7DQo+ICAgICAgICAgcmVnID0gPDB4NDRiMDAwMDAgMHgxMDAwPjsNCj4gICAgICAg
ICBjbG9ja3MgPSA8JnNwaV9jbGs+Ow0KPiAtICAgICAgICNwd20tY2VsbHMgPSA8Mj47DQo+ICsg
ICAgICAgI3B3bS1jZWxscyA9IDwzPjsNCj4gICAgICB9Ow0KPiAtLQ0KPiAyLjQ1LjINCg0K

