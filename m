Return-Path: <linux-pwm+bounces-2291-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D678D3432
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4311F21541
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A1B181325;
	Wed, 29 May 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="TH1iFNqs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2122.outbound.protection.outlook.com [40.107.105.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC75180A88;
	Wed, 29 May 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977467; cv=fail; b=DZsAdQROdAVSd/Dox3OHJCvpX7j1OZeA94AUsqddLRZDuFl/qG1yBtVBQ3439DId7UP2R8QUy2SUX42c/B6o3Hn8vF4QH5MIIIdapOWSQw3+eUMNo/X58VwhrATfKpfk3JIWq1cfv36LCXPhSj5gCaxPS7P3MDV/IWn8vPUKx5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977467; c=relaxed/simple;
	bh=a5uDQZKEc0zx+ccDkbEPJrNtOXrlxqRpOgxhJJFrl6I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cSwu4SOvmG3MUeSQsly8bEcV9VuDmjdJeibK6hi8+RKHCnjwL6RB/Lpq1RqnatUmxfXbnbqqjiG4JTG0V/QgU1P6QkcclvH4Xcwz1OsEv8uh0RCtN6tnzZj+DNltaeWP8bsUOwop1LnBNj+z2zUhrF6oRfuDOV+RpPLkdGx9sJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=TH1iFNqs; arc=fail smtp.client-ip=40.107.105.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps3fwI8l/Vf+1Efucv94L/GacrPuRjZhTCqeyCmM5tTe/vDK3h5XsXFeNR4zZD8EwL3pILibikm4nU2GyyekB0IEu9+SYkwb+k1RQr+ob2G+S6CqUs2r5DNLqFKeUQhgkHwHv8uTvDPVe3jovrkRmLZfSQJ0Uv0+OfstMp0PG0NfxoSP+YuHv4NFZ2RrRX04S4hkK6NQvnko0IuMNqSXvUCEFy2TxDcTTyLrQOVtof9xef/5gKVIIdnwfeWthFKt3a2tSoY9Tjim4TW5xDHp7JXNA0RxSB8DmWT1lc8NdzhYEW57oaNyWEmKOcZTC3/7iT3WxyUDE6CmLCxb8vVmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIMtSK+EM8pCgTvjdYWx788ni+ASBVHCRC0nlhb7Rlc=;
 b=LhQvCQxbTKgU2YkKycGTiNTWc8kxjg2CVyJMXTQ9+ZgpMwqV+58hC9dZcp52QtnEgnKV6ao9MQpKSRCKstlBoGGPA6jYFN3kKUqMa2rSFf/TfklJJzfqnnIeiIEN/jHCqEp8p/0EP67ENnMH6peRezCThp3lHE6o+xN4e2LLCAbyvcOJw0rTSGkbl/1YaDT8xlKw0DGISFBrKwfLi2JdxA0W1uf0yEfLCotC/m4cE2TEc+EP6IZFXwjXGfzte+yr42UzWK7J8wKy2GkbeFeHWa1YqAtqMiKtWS1DjP2sRRKtBquGRSCICmh430pIr6TCvxasZMTuUZw6szpyomsHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIMtSK+EM8pCgTvjdYWx788ni+ASBVHCRC0nlhb7Rlc=;
 b=TH1iFNqsOoqP5+6kNlvC9bUenv9t/SiCigiV4IiClzaJnUU9Qy62JL34N9kGn/o/v056iBBVGsFbZVTMHHk/QcsWcc1M14BCSm9hYkNBVFPWdR/e/826T75tD9knq74rIdXOV/D/r8QDws6riO5ja4FPEFDjoSIWG299V4VAC/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:10:55 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 10:10:54 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Wed, 29 May 2024 12:10:35 +0200
Subject: [PATCH 6/6] arm64: dts: rockchip: add pwm-beeper to rk3588-jaguar
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-buzzer_support-v1-6-fd3eb0a24442@cherry.de>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
In-Reply-To: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VI1P194CA0043.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::32) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdd3251-f8a8-4ebd-7c99-08dc7fc79e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUJxanliL05zOGZLWUpLM0ZnaUpFY01PazVZZVBVUTN4M05YRUVxR2VCM0xm?=
 =?utf-8?B?TGNZQ0dadzhpdkxGVktMMGUzWGtsS3V1cXU2bnBFa2J2b3htVHBocWdTYTU1?=
 =?utf-8?B?NmlqZ0JMVm5FVlpZVUxyYlk5b3ljcjhyNVg3U2cxVjZDYVJYUCtQWEFHOVBh?=
 =?utf-8?B?UFUvRjhDMVZYZnVZRmZXdEhuYlNnazJiYTVwVnU3S1ZlTXdLN2hLTnJYWmNB?=
 =?utf-8?B?ME1TeFZtYTYzQ0x3MzlTSEJrTTEwczJhejZ5c3NVeDRVNVdGci82bldaVDR5?=
 =?utf-8?B?Q1E2a20wcUxpQWhyTmdmKzZKMmczNGwzRGo2QWJxc3NDTUZQT0M5eEpXckRk?=
 =?utf-8?B?QjBEQXRnc3pBVnArNzh3dEFjM085Z2QrczQ5dWRrYi9lWXhiOFRQOXRwTUN1?=
 =?utf-8?B?WW1LYVgyZGF2VzJ0RzZVbytEWEcrQXFPMmdjQkc2TnI3TXFVL292bml0L2d1?=
 =?utf-8?B?NUF0T2IxYkJCWHFscXVZNnRBd0FySGZ4S1o3dFNiQmJWQkF3NEQ2bTFCbkJ3?=
 =?utf-8?B?ai9TKy9PTGNlb3c1cmk3MG1QTTZWem9jSUZsYlpQZTlrWHV1VHNidUxDRUQy?=
 =?utf-8?B?SDFTbVRBMTVMZm5yckNNMzVHM0tEUFRPZFBHZXkxUFdYbHpySkhkZFRJYUlh?=
 =?utf-8?B?aEdibEpMbmxpYlJ4OVgxUi81bDFHUUFjVlNEdld5S0hTWkRqMng4b1c0dkxo?=
 =?utf-8?B?Z3VCdnBLSHRab1lKVXVINkZYSVZGeCtEVzFLUEFGZU5mZ3FBYjk3NmE2cmMz?=
 =?utf-8?B?UWZBMkFoR0xhSnh6SEF0cEpsLys2UlhmN1UyVTZpOGhxMTUwT0hiN21TS0kw?=
 =?utf-8?B?ZW9raXV0T1hjZ0ozZXdTU0IxdVlKNkdxNE95Z3U3L09GaHJrTit2TTl3b3A3?=
 =?utf-8?B?bWRaYmdud3kzRnhORkNqbFFFaVB2S2E1QllNY3pKRWdrQTJvNU1IeWszeVdQ?=
 =?utf-8?B?N2xrRTlEZXoyQXNLRW9RZ1FVOHV2ZXlNRW50TTRYbEdPTVN6ZzUzZ3hiKzJF?=
 =?utf-8?B?U01vUy9sM3FydW9TemtFUEZWbEI5cHBJV3VyTWk0ZytGNitpZVk0Q1c1NXF4?=
 =?utf-8?B?WnpxblBKZFA2Z3RqUlhVVUxaaVBxajBWN2MvckwxbnMvQ3FLMlY2aUV0R3Y2?=
 =?utf-8?B?dlEwVnd1VkRQTzBvVExpRWd3OGROZXAxVWMyOWUvVGlUVjdNdFVlSTA1YlZx?=
 =?utf-8?B?RE0vT3NWV3Yza1c0ZS8zc00xVHpOZHdGK3pKeEl4RHhvYWhYZDJGdXc0TUNk?=
 =?utf-8?B?a1FJU21EcDdjbE5QL2VPR1hYeXgyYjMvQm9ySVRCNU1CR0VVdXkraXZRcWVx?=
 =?utf-8?B?YW5YTHI0cVFLYVEvOU1vQytQeTkwbU9BMzBZeVd0TzJ3eUY3WjNyUU5xREVD?=
 =?utf-8?B?b3FDTDk4RVN4OGVsb0MvVUhFcEoyQ1VMaCtnM1JBa2orY3NLRlR4U0dNd0hS?=
 =?utf-8?B?eUtVU0x6SVRIbDhIRmNqYWhGb3BaV2lxV3I5enNKSGlMQmlNaWFsN2ZxM2t3?=
 =?utf-8?B?Ym1WTGRUWFFCSHZDWjI4RzRKQ1JMdFhrd3N3NXc4VFluSzlVN1ZIUFh0MW9W?=
 =?utf-8?B?ZGJ6RFl3VEJUNXk5cU9qSjZSbVNLbUd6MEFQU2FXR3h6aWR0eXBNZ2tWWGFu?=
 =?utf-8?B?ZU5pamxkNGYydVBtVEVyRVpXN3JyMHBzaEhla2ZHQWZjTFZwWVQ4N0k1NWtF?=
 =?utf-8?B?OTVxZXNRcDlnQmFTQ1hsdUhhZ3J5QWhmQ1VGcGlpeTNrSDkrRytYcjFqOFAv?=
 =?utf-8?B?bFQ2WEM1U3dWS3IyMVpNWE83QVcxR3RTQnVBTjQxblBDYXlwNlVyR0dGT05X?=
 =?utf-8?B?c0gyN0xjVXdjYkIxWlZlZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtXdlFWelRNaGd6YSt6QWcyUUtzYXVIM0VDZDMxU1hLYm9OcWxiU0dXaXBY?=
 =?utf-8?B?dUczMEVNd29UNG5TZ04wV3BqT0d0K3pjSTRrTFNKc2VobnBGZ091bXVpWHVj?=
 =?utf-8?B?MG0zT2hhbzhPZ05Vb0JqREppQ25oKzh3TDA0RmxuaUNoZGNCZHNML2ZuL2JP?=
 =?utf-8?B?dDhwTFFwczMvQ3hldXdBYlU2UEkxajFZY3IzRkpxaG93QnBBaGJYZmhMN0V6?=
 =?utf-8?B?OGZHNW55N3BiZHh6c3Ixekk0SkRsSEtRcFkwOWRtU3o0Q3k0dVV6MG53OWMv?=
 =?utf-8?B?cmp3SHdvd2k3Y3F1NnVvODdVU1FOdnRZRndINEdnL0tua0xlN2Z3d0lvcExV?=
 =?utf-8?B?UmRFVDdUWlA3QzBMRnE1NHN5NTF4SlI0eGpZWlQ3b0MxdmZ1VXpCdHJyeExH?=
 =?utf-8?B?UXptRTVrUXl4dGJPUng1UlhjY2d5b0dod3l6dGtYN1FhMkNRWlBSWjhtOVhF?=
 =?utf-8?B?NUdJNUxKamovakNtNldvenpHUUswRldPcHUxa3c4RGwzeDlRNFBGRlJvNHFE?=
 =?utf-8?B?Uk9KcS8rUlliWjl0ekVuOFdnazM3TXArVmI2U0ZPcThlcDJFMUxSK2F0elBU?=
 =?utf-8?B?Ulc5dWgybU5nWUxRWms0Z0ZlRXJDVHEyVTZWemhJcUtUUzUwTUd5blVoM08r?=
 =?utf-8?B?MHkycFpTQ1RvajdnRkxqSVBlME1UVHJzUUlpVmZXU1ZEa3RicDgwN2t0Rm4w?=
 =?utf-8?B?N3JNQUNJT25qYnN2OFVURHliM01YZ0xFNENWWjhtTkxTaTFVM2trV09tL3E5?=
 =?utf-8?B?MUxRSWZlUzBsaTZneTF1WGFQODYwdzc2OU1uWUtibGkvRzdXVmxyL0IxZk1Z?=
 =?utf-8?B?ck5MTVVoNms1bnpqdThadlNuTTdaaGw1cmY1dUZwaS9XdVU4YVBNTUpncXdz?=
 =?utf-8?B?U2w2Um9EK2c0U21ENzJ2TlJiUm1NQnU2OTkyRGF6cW82aVJlekFLVkRtWG81?=
 =?utf-8?B?RFhaVThuc3hHazNvQzdEcEJRM0JrN2xUWW9VSUJDVlJtRlM2ajRZU09PakM3?=
 =?utf-8?B?TE1vZHlKOHBhWFZyd3NlQnBDN0M1SkRTRW1Ib1J2RWVXbHZIbXMwc1FOSk1J?=
 =?utf-8?B?QkpqZ3ZGYTAreTJSeU5qN0orU0F6dEtTYWMwLzNITmszWDVkWnp6UkxTUTg0?=
 =?utf-8?B?MGkrL3BRQUJCY1pYb2VwWXVxRW5ucnU4RDZ6a2tVRkdpRm9Tc2lldlVLQlVy?=
 =?utf-8?B?UkpBM2F2dzN1WVBzNGZWUjZVOXErdjZIK2hGczZRamRvM3J5MVVtT096VTZn?=
 =?utf-8?B?UlkxSGJaQ2R1YWtYMGZzVmJtL2kySUNZUTBYY2s0VjF4bFBGeE15aW83MTNr?=
 =?utf-8?B?Z1dGZVZtRzVkVlY2SSthTGd4ZnpoVms0VStNSVJCZnlCRUppYWpmdVRBUUdy?=
 =?utf-8?B?UWl3WjVJclRvNXMxekFBMnRxZXJkbENTQ2ltWG5rbDFUMVptZ1plTGgvekYx?=
 =?utf-8?B?czNnK1duODI4c3E3YjV5V2l2cWwxTjQzd3dxam9UYWRyRmNQeWRvYzFhZGhu?=
 =?utf-8?B?Mk5BaE0wdHJvblpqQ2ExOTFVQ3Q4a0pUS0dGUUUwOVNGU3Z5R2Jvemw3aE4x?=
 =?utf-8?B?QmpZY2w4RnF6dmpNc0x5WDBQREFFU0dhR1J1VkFWckRMU0pwUmFyU0ozTUtH?=
 =?utf-8?B?UkVEakZLRTgvc2NwbUdzSHQwOXFYaGdOei9WZFhwTGN6d3h6YXh0VzNvVDBP?=
 =?utf-8?B?VGZMVmtDVnpxSHhOeUh4OWc5eFlubi8ya2QzdW83dzBmVFFGWjgwaGVicGpO?=
 =?utf-8?B?UlpNejRsOWVzdHg3MkJlUzJPZ0hPT0lkenAwcFdvUWVXZkp4Y25mNjdlUlVF?=
 =?utf-8?B?RDdWOG1HNk5TdjN2QXRlM1VZT202dEJyYzZESUg3MDU0cURGb2dHZkwxcmhS?=
 =?utf-8?B?MWZ1Q1hjUjdhK3YrZ1A4Zjk3cEpFYkw5MUJnQyt3NjR4Zk5OTHVJYzVRaUFx?=
 =?utf-8?B?WGNLUDlDNEVUY0JWOW5JZFd0b2d0YjExTWV0UUovaFBXQWhCYjNOR1FJeHdJ?=
 =?utf-8?B?QUlqOUh5dTgrb3RkWUVJT3RHbHN3UU1yeEdJQ0ZXdXE2S2pTVk5teXNDUWh6?=
 =?utf-8?B?Qmx5VmhsL2VWS3dIblZGVFp2bGx4a1Bid3VGelhIRHp5VXQwdUIvOGluQ1hO?=
 =?utf-8?B?eG9US0Y2ZGZRQU96V3ppTk9yazdSZ20vczJ0Q1N0T3ZDaVBOUXJNYktjRFdw?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdd3251-f8a8-4ebd-7c99-08dc7fc79e91
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:51.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lD3RkbT1JGS4yKo2xPc25QSZywobvgRfyaQwte8mtzWTIaw2wWjKbyO2nrsJ3bBB/BB/eFbu0ketT5FJRMUj0fFX8x72xkp034aGXkQFYUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Add PWM-beeper that uses Mule PWM-over-I2C controller on i2c-mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 14f1322c162f..c7c8683dc1ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -33,11 +33,17 @@ button-bios-disable {
 	aliases {
 		ethernet0 = &gmac0;
 		i2c10 = &i2c10;
+		i2c11 = &i2c11;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 		rtc0 = &rtc_twi;
 	};
 
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&mule_pwm 0 250000>;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -267,6 +273,18 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c11: i2c@1 {
+			reg = <0x1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mule_pwm: pwm@18 {
+				compatible = "tsd,pwm-mule";
+				reg = <0x18>;
+				#pwm-cells = <2>;
+			};
+		};
 	};
 
 	vdd_npu_s0: regulator@42 {

-- 
2.34.1


