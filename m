Return-Path: <linux-pwm+bounces-4078-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D99C87D5
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Nov 2024 11:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308AB280C3C
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Nov 2024 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF31F9405;
	Thu, 14 Nov 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UnoibiHK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9551F9402;
	Thu, 14 Nov 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580778; cv=fail; b=PyqE6Vf9Pp6Jy02jgeVt0VPSDZ3vE1V5TIUvLmoMfGlSyOnZJXSdlcSA3ianc+HRbmiReahzRstUbPnRYy/PD+Qoy3p2wgSX/zUQDKT1WGcXKpdtjSGr7eGUItLwayZnisZmTbBas6j4Uo1CIYhP8lM2esTYnBeo1QF1a400hqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580778; c=relaxed/simple;
	bh=uWyUOCF3M5xVYMdFknVyPL3CSAlcsbKU6f7wgGF0G50=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDb3HqeU8ZfiDUxTYh/kB3lcSPF9SaCCvKPIo1zamJ8XWqPOwG/F1EcYitW0LoAdg77G176Adpm/E50zVe+G09Rv54NKHM4hxjj7bi3XvbwECvyxE9dUX4/LTjnmuyVNzEbH/+JO/wlyg/iv6rHYqvpFVSOmpyfFCM46rzg/kow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UnoibiHK; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE8Txmh001391;
	Thu, 14 Nov 2024 05:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uWyUO
	CF3M5xVYMdFknVyPL3CSAlcsbKU6f7wgGF0G50=; b=UnoibiHKKCZ5It0fFYFU9
	RwyGOCfyh/6OanUeZk5a3BSEZgPLSPM4DEulLbPueOwnDE9PjRZkCk/nHmB2WycJ
	272mh9MK2xCK5FWz5qGTovQU8PnmkPHT1RRMF2id2Y9qSTmBuDnw8BhCZM9lbHiv
	6zbb/rlr6vYOrQtzorIVxcD5KJGG5x+xEKX799h5OZGnj6dXn/1gvFQf9q+iltAY
	D8WltVAaUx24l/KMzlD3BgKyYE6SvU6L9FKiH0ux0VYzt9BYECyGRrOd7jJquLC3
	jH1MdARbo/yA+wmN0m3N6V1TgnSlYrZU/oCCeJONMznrtSM17Drp4Y2c8bbEJMoA
	g==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42wdrgrqgf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 05:39:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAvO/SA7A+dLPIY8hPsptfV2JutcKWi6TNJTNeBx1vmhTYeBFj/A9eYl4u1+HmHZcyGyQyQ9pDAEpzmb4IIMF8KVQdj4C8m5jsgy7iE9G7L/I9P1XWSAJu/Z4rljElZCAKf6yWLIy9CEXfKIfwqIfUtku9IEKOydCvEGz88jVxe69R22ZQ8gLnnK4pahqcYnJj6oEzVAmk3pccrvLljLQCAg/OCeoLvAhLMz/XCf+b2Wg5jwCSJ79Dxi4i8MBlZf3/SOONoXTKVItL83MUeQgH/mIxl6mdQ6NL+2QwY5iJ4UQ9yDLCZvauCZSSL58+PiNUj2FlPZG7nVSrt6qAWDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWyUOCF3M5xVYMdFknVyPL3CSAlcsbKU6f7wgGF0G50=;
 b=mNQSCuQ3Ji8Wr2hpajxVuEHTTkCnNiGd+Wz1ZrIFSfDF/2CRoktDAzMUzp1f9muYaamqmiVvfukiNL4ExGCDksG+VfyMqBxr44aJ/2E7caWZmdMPqnbvIzsIo3AfAPl6rXrE9Gbo/GBfy/C8sTSWskcx4IPsckxgZnENFQC/ZcyRB9T54obmYFIvNX2DSbc/I5r7yefcmyPgbf6on8cukaK41qISgP4ESNvFCKVaaAZvtW74W5PQqJyNjFh9qZfW8/seWFWYgOj/ncazMolRi9cruTahARuO2brJ94y69knlSpBj2hDugYpoqoJkWOpIZAV6M9kJvjj7Yt9NpSGkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM6PR03MB5113.namprd03.prod.outlook.com (2603:10b6:5:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 10:39:16 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%6]) with mapi id 15.20.8137.018; Thu, 14 Nov 2024
 10:39:15 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
Thread-Topic: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
Thread-Index: AQHbNDMFlup0uAxPr0GP3n6fJH5kPrK0ExqAgAKHNyA=
Date: Thu, 14 Nov 2024 10:39:15 +0000
Message-ID:
 <CY4PR03MB3399FA960416CEC64E1FFF929B5B2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-9-antoniu.miclaus@analog.com>
 <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
In-Reply-To: <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFoWm1Nd1l6RmlOUzFoTWpjMExURXhaV1l0WVdabE1TMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWVdaak1HTXhZamN0WVRJM05DMHhN?=
 =?utf-8?B?V1ZtTFdGbVpURXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STJPREVpSUhROUlqRXpNemMyTURVME16VXpNRFl3TmpneU1TSWdhRDBpVm5C?=
 =?utf-8?B?SmMwRkplR1JrWkcweU9EbDNOemxqWVRkUGVHRjNWaTh3UFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZFYkRSQ2NIbG5WR0ppUVdWWGRrMDBOM0poV0dobU5X?=
 =?utf-8?B?RTRlbXAxZEhCbFJqaEVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGdGFUZEtiVkZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM6PR03MB5113:EE_
x-ms-office365-filtering-correlation-id: dd61cae7-63e4-45a1-51f9-08dd04989637
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NklPUVNNRlhTOXBIU3BqV0hYWHlpSTk3MmtjKy9rOHVIZUxIU1J6biswUlhV?=
 =?utf-8?B?MEFCWlNRN3VSZGhXclZEcGhNbm1IUTZ0blRIa2lwYVltVDFERUo3TVBxYWtS?=
 =?utf-8?B?aSs1MU4vU3FHR3pOblFYb1g0bnNhR2k0Y01FTFR2Y1ovM2R3YTh6aVF6cWJO?=
 =?utf-8?B?Y2xocG1LVUR1bTJuallQWFY4dndXME9QV2p2ZWhibEJkdTZHQnRyMjZ6ZmJv?=
 =?utf-8?B?S0gvVUt1OWxVMXNPV0h2L1VPSzU4TEg5ZVhLMmg5a0JJN1RlM3lJaDRnbmNM?=
 =?utf-8?B?aFVDNU1zeis4cmsxQzVZS0NRakpWQTFYS2UrQmN1RlU4dVVUUDBoaXRjekFx?=
 =?utf-8?B?V1ltS1BHZWhlbkhqOFpENldpSkUvY1NLcVhSd0hERGlVc0JNTWtoenY3QzZ4?=
 =?utf-8?B?OTdnNDJrdVM2djRFdTJjMUlORVcyekZGNXhzeC9MWVIyS2tDVFVaa2pESWxj?=
 =?utf-8?B?NXFCNGRZUXc2QTJOZ0hRNGVqeFBTUlRCeURteXVqL1lBTDZWQzl3NGFhMUlL?=
 =?utf-8?B?bHpOWXZRZDZUenVMZUxXbU9qRW1kY25PRDBDUnhrTWt0VUVGUyt2RG5xeVdX?=
 =?utf-8?B?dGhBR2xRZEV0VHZ2ZWkvTFYrMGZ2N25aU1V3eWwvRUlXTUlKeW9VSTdlNnRQ?=
 =?utf-8?B?U2Fla1pDVlBWdkJUelIvYVgvWFFqaUlrR2FWOUVQeitTeDNVTzZUSUtPYmMv?=
 =?utf-8?B?OHFGSks0OU1YMG94d0VETk01Ryt2UlRrUGpEclhpdy9hSXVSOHVRaDAvWHFV?=
 =?utf-8?B?bEw1ZkVqeHdIbnhnaWpvZUFhMy9LZmtZYzBLdWdLQzcrQnFjSEZyL3ZFSkR0?=
 =?utf-8?B?OWhOQVZaTHY2a0RwTXdtMmxLT1pWaXhvRkNnaTBnSGc5cnhyUE9ZS1V0VHZm?=
 =?utf-8?B?ZWRRSTZoREI3VHdPK1YyRFJ5d3RKWHNzL3daNGZicWsvTjBOTUV5WC93K280?=
 =?utf-8?B?UDZrTE1Uck5aVFBWcHJwTXNRQUxVT0l1Z0xIemhBQ2k4dzhwdDcyMFZWYkJ2?=
 =?utf-8?B?b3FKNk1Hdzh2RmxXVHRnZERSS2NhMjBEMVdHWnczdzJrNFNVOE0xT0hvRW9p?=
 =?utf-8?B?Nk14TGwya0pYR2dWMHk1cC9oZXRyVGFmUVlGVTFydkhPanR0YmQzblYwTis1?=
 =?utf-8?B?cUxtSGEwSko5TXkwR0drc0taaWtuWEcxRGNXRnRSeHRhcTNlV3paejQ4T1N6?=
 =?utf-8?B?dGVIaGNBdUgxRTF5K0dTanhpaTVobEhpWjNvL3pTZ0VEeHB6V3p0RFQwQWNV?=
 =?utf-8?B?ZCttc21yNzFYNHV3dW5CTlEwMzFIcXdYUUZMU1lraGl2MGpJQS9CeXl0TUFt?=
 =?utf-8?B?Mnc3bmI4b1ZTeHgyeGhBL09ESGNxbFVNWEJzbzNickFUTDlkMmE1QTlMYUxZ?=
 =?utf-8?B?UTNEQjVwNVZzcXpyY0kyQXIyR1IvTlN4MldxK1lKV2xRbkc0RXRua3lSMFhB?=
 =?utf-8?B?Q2dEL01rZnJra1BpaWZRbmFGdnNZanhpVEZzVU1VS2N1Z2l4eUd6YkpnMTJw?=
 =?utf-8?B?ZWZSOGppb2hTYmZNb3ZVZ016YW56bi9lNnhWcVdWTEVEdkFhOHdBQnNLWkZL?=
 =?utf-8?B?K0NlQnNUVGxmTDFyMC9kUXRmN3lTRHJBdWd0MHkxT3dRSk8zY0V0a3hxUTZV?=
 =?utf-8?B?VmxvUlJDZkYzT3RFYXFRRitWME9kU0VjdW1sR2d4VUU4QnZteUNKalVLU3dL?=
 =?utf-8?B?TlJ0RDE2UmYwcExuQkRzY3dXd2ZOYi96eFIreGs2eWsxVFVSbmpETVhCS3dh?=
 =?utf-8?B?dmtoMEpaRytHV0poemU0aHByYVFtbngxMVV3Y2h6L2VpdktRaGx3ak9EYkZR?=
 =?utf-8?Q?jm9RlckGyH39SLsdHIMmWgIS6c+eGaey5krM4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1BROFBhYTJKQ1dxS1pQUmdvMm0wQ1NCSVhQRXYxRFFBRnJLUkJPUjd0MUhu?=
 =?utf-8?B?QWoyd0wvaVRjaW0yZ0h4Q3g1RjFSN01TbnpDTnNKR00vdzNwK3FMYjdBWlBk?=
 =?utf-8?B?bVJlSFd0NXV2VTBzcEZGajFrbTArR25vSVFsb1oxQWRsVmMzOForbUgwRnM0?=
 =?utf-8?B?NHVzQnZtVTdBWmdaZjE5RFNhaHNuOW9FVEtqWS9xaXoxaURWVjJJVUhjSDl5?=
 =?utf-8?B?K0o2aCtoc1ZsSkozejJaaHg2QWk4b2E5OWFrZ1pGYmxFb3FsZjRqd05Kd1Z2?=
 =?utf-8?B?VUF4Wm4rcmhPLy9acEYrRVk3Q3Z2Q1FxT2ZRQkd3WllxZnlKUEZqTWF5TXJG?=
 =?utf-8?B?MHRDTlM5VFVGTUp2dUQ5WDhId0J2YWMrOFRkbEJSeFJUTWtGMkdhVHNKdFF1?=
 =?utf-8?B?d1A4TWszcm8xY3ZkNUpCRDJDdG9Wdm1DdmQvTTQ2aGlRVW5zMzJGQTM3c2Jv?=
 =?utf-8?B?Ty9BTDV0akFuK2hPUXFhMXlSbWU5VFhGbEk3Q3pmSk5OQk1hTDFaMkFpZWZQ?=
 =?utf-8?B?dUUyTExIQU1EeWgyWTF6RDVyYi8wdWhqZ0o2dW4yUC9OVHRmV1RtVkQzeGda?=
 =?utf-8?B?YlJ1WFNkeHRlem5adXdXY0wxa2dmRzZ2cGkweFk1TmNZenErSXczeWpNNytH?=
 =?utf-8?B?T3p1SGRxYndUaXgxU1pyOTN1dmkwQWhmU2E1elRjL29QRFNPVVJnMlNxOXZI?=
 =?utf-8?B?YjVvRzl6Q2JSdVJZZWNuNFNzcHgvVitia0hlNzVsZUpTaHNKenRkanZ5dlpy?=
 =?utf-8?B?SU5PZ0pTUzFzMW1oSzI4RDlUa3ZDb2ZXM3VmLzZ1VmQyZkwwQkM5TmhCaDNq?=
 =?utf-8?B?SVRXVmNXaURZZU44djJPOVoxWlFFblNtQ3VTYndaQ0RVTW0vOFp1czY5eXFj?=
 =?utf-8?B?K2tnNDhXWi9uc2ZLaFg1TWhPZXRzbkNvN3ZMNEJYbGJxNWdVNHp3eUgvcHg0?=
 =?utf-8?B?aityUlZyeFNJUThmWEVZcmhBVnVaTkZQbktHWWtpOVBsdExucEJ3VFJnSDNm?=
 =?utf-8?B?V2pyajVpUmpUV1hqYzlkZnJFQW1TQk4yREhpR0s3VDhxMkhmZ0wwcTFoeUlU?=
 =?utf-8?B?c0ViT3kwMThtY1ovbmFtcHFpOHF4UFZKelh6SUFUZFRpdkJhRFhoK0lKd1RZ?=
 =?utf-8?B?QWZhSnlVenR3RERCTTBJS3RJUUFXODg0ZXNQTlFQQ1daR01KQmNLczJ1U0FT?=
 =?utf-8?B?OWhnTVA3K2RqVDZjc0x1UU9pYURJTUFvSTIxeEgrQTYyUEJrbUhFTTJtNXpU?=
 =?utf-8?B?NnQ5QVBOa3lTUy9VS2dHWlVOT09Ca1JSVXM1TXZYZEJBRDAyT3d1cTl0S2VL?=
 =?utf-8?B?eFVRdjVzR2RuWkdMZ212UGJzSW1vTThvUkFncXBpMnpmUkYzMFc4NmZGSEFk?=
 =?utf-8?B?Ym55bFkrNFVxcUhTTGx1elh4TWN1ZFhIUzlDYW81dHJoTVZLazVFVnM0bTZo?=
 =?utf-8?B?TTRYeE9UTDZ5OGlzdDBpSlVEMFJTblFwWXdVa2NqYThTcTNFbGI1d09iT3U0?=
 =?utf-8?B?MEZScSt0aXkxRHRjQVlEWXlaalVvaTRNVXhOZEw1R3FuSHpjS3BEVzhpYVJM?=
 =?utf-8?B?MTl1U2ZYTjJ5RTRUdWEvMUpEWUtXYXp6K3QxQnlLTkVKZkJXMGJmRDVzMWty?=
 =?utf-8?B?MjAyUHp1ZlFJcmYrT2Fsa3BFUnNxZFdsVkZHWHFGWFpUVVBtNVVkdGpCQ1h0?=
 =?utf-8?B?Rjllb2lycHZNY1BZanNKOWZqOG1VNjdHUGRCNW1lUVVnVjIxY1pFYkNDRVhs?=
 =?utf-8?B?RUI5Nmg0MmtOK1o0V0swT0xISDVoTDBsS0RHa25temRKaVZwR05XOEZsRWNC?=
 =?utf-8?B?RHlNWmF4b1JFc05sc21TWmdRUlN6N01wTm5teTV3OFhmeGYvUXlkc3RmMk9K?=
 =?utf-8?B?MThKbXdjTkcvVlovOHFtMkNMVjRtaEVkNCtFRlBIK0NFZWFpSWM4eTlOSE5z?=
 =?utf-8?B?QUFweEFJelFGaGdpQk1NdHVtQlFoOUdFUktvdHIzSDh4Z0RLcFptYnpxOHNp?=
 =?utf-8?B?bys3MUV1WHhQY1pDRzdUSVFpajAzY05mL3Yyc2xxVmIxZXlSRysrS3pldDBt?=
 =?utf-8?B?eFRVanRIM0tHQUQxQUtMVE94RTdxYWtoeUpKbXpOc3d6SWMwTzc5c0Jvc1NB?=
 =?utf-8?Q?p0bx5BU1KP/wgImmoBlbQJ03i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd61cae7-63e4-45a1-51f9-08dd04989637
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 10:39:15.7647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrziLTYZgXby0zOyxgDyxEdEnNlolzA8fXsQzJxSU8Vm14CmwpAxar1hO0iL9vwLnlXS6XmEmiFlUAMzC0pBBZqw6DUR4f4kxw9AUskHGM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5113
X-Proofpoint-ORIG-GUID: aFCf9Zub8bgQ2AWJORw2x41aGm3BihQN
X-Proofpoint-GUID: aFCf9Zub8bgQ2AWJORw2x41aGm3BihQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=724 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140082

PiBPbiAxMS8xMS8yNCA2OjEyIEFNLCBBbnRvbml1IE1pY2xhdXMgd3JvdGU6DQo+ID4gQWRkIHN1
cHBvcnQgZm9yIHRoZSBBRDQ4NVggYSBmdWxseSBidWZmZXJlZCwgOC1jaGFubmVsIHNpbXVsdGFu
ZW91cw0KPiA+IHNhbXBsaW5nLCAxNi8yMC1iaXQsIDEgTVNQUyBkYXRhIGFjcXVpc2l0aW9uIHN5
c3RlbSAoREFTKSB3aXRoDQo+ID4gZGlmZmVyZW50aWFsLCB3aWRlIGNvbW1vbi1tb2RlIHJhbmdl
IGlucHV0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8YW50b25p
dS5taWNsYXVzQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gY2hhbmdlcyBpbiB2NiAoaW1wbGVt
ZW50ZWQgbW9zdCBvZiB0aGUgcmV2aWV3IGNvbW1lbnRzIGluIHY1KToNCj4gV2hhdCBpcyB0aGUg
cGxhbiBmb3IgYWRkcmVzc2luZyB0aGUgcmVzdCBvZiB0aGUgY29tbWVudHM/DQpGb3IgdGhlIHJl
c3Qgb2YgdGhlIGNvbW1lbnRzIEkgdGhpbmsgSSByZXBsaWVkIGlubGluZSBpbiB0aGUgcHJldmlv
dXMgc2VyaWVzLg0KDQo+IEkgZG9uJ3Qgd2FudCB0byBrZWVwIG1ha2luZyB0aGUgc2FtZSBjb21t
ZW50cyBvdmVyIGFuZCBvdmVyIGFnYWluLg0K

