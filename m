Return-Path: <linux-pwm+bounces-7431-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0587BCBBDA
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 07:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D942181A
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E31E7C12;
	Fri, 10 Oct 2025 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KZ2yjWjT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011002.outbound.protection.outlook.com [52.103.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B8635;
	Fri, 10 Oct 2025 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760075672; cv=fail; b=KJy7QHuBHYU6IphbAPxvvRmv+AMbJFXDGX4dEjfAVT7ElKysASCPA3YXaz0/+PcMyjcKCCh+3i+TQzki1o+ecHWbaMPSRJesGr7x+wguEgySqMFAZSa+9mxgotGo0ILpLD3eUxi+vResdLIxPKyEF/oRonYT/9VEC+7dxy6KzB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760075672; c=relaxed/simple;
	bh=HUvgKd1SzEPJc8CxYz/Z0X9UnQ4Y0KtwKvlxEe3jS+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9lksHCNKXXSHhh/M+JEWKrb+tgw9NAD1f647OGa88K8FhSGjsg18/iuUZQqJOTIEGTg+dAKxA0tdK1UR41wd4PijAQh7W+fDbc/RZs32y/sGzEX8pHOVJatR4zcdk8GZRxReMBEvyCHLVkEDAE34q4wi0gXrumaR7qIyrgeq6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KZ2yjWjT; arc=fail smtp.client-ip=52.103.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+IPacCt/icPbFxOu5EaAKilTZSPTULtttUuEKYN010viy1fZ1nylIeYW1KlzB1wjJgnZKsg6GpMLK475t1xInxLNe98V7Xw63BByd5DxI0nicQmE9zmqunnABUDvuoBA8BKBJZQi3UJ1AvB5bYQ+i+OYiklO7BBUxsGKDRbwlNexTHJzGW2z5O+gTIhTeFizy0EHrm0xCoOEZabdCB+b6blX5MK2l2dwkNdG2EvrywcMVnyODQ3+/IwteF/YahZpX6TMxFKcfj7YNm4RG/hBJ6MhVGB8h72prT+c03RRlmEI6KN/lnGsSewElJxhiN8F1i5FKRUPsnSEwXM85/B2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUkcBZmEuyjrlRuPXchdFO29ZcdERJatwhemzYNiRWw=;
 b=CNruWgrw9IsvWVoDEAHK34QJ3beq7wao4cBxZkRMQfzBRNj03EetESvzYCXVcMiR7YoZA/MVIU2MEEdM5OxnFET5vYo4GfIw6VaXG0CRCMJ6khPMiYtBc0IBUexmb5kXqYf0HvstB1UfJWJDJ0C0n5YqqvjGnKVcD8jUkv5lLfM/kYtcTlEkYX6B7ySLl09mOS82ogmCyt0Gdn5kePpaWY3HinN+IeG6vn2wPLEKdeKhXKJxStzMKnmf8tD1FY38RrMPL1WqPle6dtAg3BikGzKGBDa3GheyFyqjKI/G6myXczhAGrItOVuiUj7uezxk49OpeH1hsSPEZu2Ow3dhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUkcBZmEuyjrlRuPXchdFO29ZcdERJatwhemzYNiRWw=;
 b=KZ2yjWjT/9ZWkxo6Ic+7oEDXV9JlS2tcAletU33E1/Bd9fa9PSPMS3Kb7tTJZQIx5A8f3qGLsm1T0nBC0qgiFqi+qVmDTv9kN/T4F4WKmpxzfc7ihUAdHZkEFHppBXIriL4MTQIRpmtNMFAyMQNN+CDjZXS1SNsgv9DqOH7bSgWkg9OJpjsrstde5eZJSYaNaErlRphdLw0/FXb/+9K+J0WGlNLheP+ZS70hSRN1pB2MK0Ti+pgJrHu6jYIMyUp2Lg6hzGNlxsHk5vqYpfODzR87yxtjKtjbUMsjvTwQuaV41Q6GgMzsKhWNPSQzT+xUBNe0Ejvx1wMlxmer0NahQw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH9PR19MB9226.namprd19.prod.outlook.com (2603:10b6:610:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 05:54:28 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%6]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 05:54:28 +0000
Message-ID:
 <DS7PR19MB888323C008CB4F19864260FF9DEFA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 10 Oct 2025 09:54:20 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/9] dt-bindings: pwm: add IPQ6018 binding
To: Baruch Siach <baruch@tkos.co.il>,
 George Moussalem via B4 Relay
 <devnull+george.moussalem.outlook.com@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Baruch Siach <baruch.siach@siklu.com>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
 <20251008-ipq-pwm-v17-1-9bd43edfc7f7@outlook.com> <87347tl6kj.fsf@tarshish>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <87347tl6kj.fsf@tarshish>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0005.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <4a7f3aea-d8f8-4b8c-b672-729eec89f5d7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH9PR19MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 709eeffd-9854-4790-99e6-08de07c178e7
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaTud6KoFxL4vINU1fSXCSZ4IVqZjb7630XJXBHTF8bgOGjTEMTSlHPnnH3ORGzMB0j6RTJ4Rzm83z1ydQNOwEBiUp7mv/1dNqVQdWvELZaasYp1sa+ujkUAaklPlpKV+eFuWMqxymFkr0gege5aabStLeO766kN3QFPn2HebRUDmTari1RuAl09lskN4akgo26XMal7+46+RKM3UgMctyThhv8DvNvdZg/u1Iwp4fWquvQgCLrm7zwkZkh4ctI1tNAThb+JHo2+rwT5G2VgxRQ7B4j/1l0eD2+l5S4MegC+pJ8pbOPAmuIqyCfa6utrWOAro5iUD9TNaQ+rWTh3LA22+xhst9k0IBz08RtUdOwQzDICv2FzCi8IFLunl1wRyG0gM27ZDNlJf22Pwpp4EljOfU/7ygo8pfKoBY/RQ9ny0xYV3K/vP6Nya2XBLThbhHmkphRJu6mtcZ/plIQmp9tU312QsRYFmFgqcdsDBvt31jdD2CPZ+IupxR2RAYAH4UHVPQCarZ3e0c5gdkYXLNkIiCLNIk/9M2hTHxfdNixUQK0YGjLaOmUEk4VacaDiYn0SqXa9bJgIJP1RGA7RyydpcuFv+J6lT2f7fh0NgR1k8GEgfHWmgPuViM8pNUrq847BeAtjZdTxrs8GRFH6F+VJqYby2fQB8XpWwYCxEMebq38RAng+oGF50hqLMqf/4zVG1KGrLAVfoJ58eWQHTUJFhPoJdP4P+1ISr44YNoQWAWyKwpOZoNhyRQ0JEMBPwy
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|6090799003|5072599009|461199028|15080799012|8060799015|23021999003|3412199025|40105399003|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzgzQlR4V29DRGowOUJQR1VEbG4ySXNZbnl3UVVXV0lmdFhFcGNON2JWbkpl?=
 =?utf-8?B?OWswYnVrUTloa2Z3WnpzSnRpTkJlUDUwdUZLMVVCR3N6d0pMbithVC8yVStN?=
 =?utf-8?B?cGdpVE9EWkhXenNHZWFIR1pQSVc0WmNYRE1Oc09YdFFPUHdBT2g2TkhYRDEz?=
 =?utf-8?B?NitqRWNKM3Rsc01FOXF6cE1vcm44SEpKZXhrL3R4L2dSNXpTZXhidERqb2R5?=
 =?utf-8?B?azVBSnh0WmxlSzBBYjRvZmxJTHcvQ3ZXcUcyWHdrdXQzOXVyOFBJMzdzcjlR?=
 =?utf-8?B?WWwrR0MxRDZjOXBiNU51WDZYbDNGNDczOVF6WXhxVmpqTlRnTkJ2S0pob0w2?=
 =?utf-8?B?SEM1NlBwNVVYWS9DSDZ2L3d6R3VVYzc2aUhNZnZWMEQ3WHBqYytlWHFOV3p0?=
 =?utf-8?B?TGxvQnk2TnFkUjVXUE1lanpTZGRWU1BHQ2gvNDl6VHFxd2psTnBiU01Ubk51?=
 =?utf-8?B?aHVyRmxzYlRRT21rMFRTSEg1WlBxa2J3a2RnWmxwL2hJMW9SV1BNMXRHQktO?=
 =?utf-8?B?Y1BVa25NR28zOU1RV0dIcDh4eSsrcDVoOTVwYmVVWVUwT2hjcy9WTHFMVmpJ?=
 =?utf-8?B?NFVvLzVpNkZFb1IyN1QzU2VGdUVKNHgrUTRvSWw1eFFNL0V1Q0NyNHFxejdk?=
 =?utf-8?B?ZUlWbG5hZHlHMlBza2xCLzJkUW9hK1FQR2c4MU5LQ05IZzA5cDY0NjliUHVz?=
 =?utf-8?B?a2dFS3BGTFRsaUZPazV5UytscHRoVGFnMTJ3VWZuQ2tBa3dtTCtwZWg4Z2ND?=
 =?utf-8?B?VVJYZXljS1FQdGZsT2lQM0JFZkVFQWpjTmRXc2xyYnpSdHhJejJpN0lIbjZn?=
 =?utf-8?B?M2p6Z3loekhVeGJ6Q2ZhNy9ma3Y3S0FaUkZxZnNmaUU1dDM5bDJMelduVHBK?=
 =?utf-8?B?a0JTRlJUZG5WNW5aR2c5bnNlRnZnTllBUnd1eHJ3K1ZnY1ZRZVVyc2lpZU1N?=
 =?utf-8?B?aCtRbHFBRytVd0hYRkhoMCtneW43NjVTWWZBWEQreTY3a2dOQk1IejM0MEt6?=
 =?utf-8?B?WTJ4Y1FZbTFpb3RwM2NWc0k4RlNFOWUzMmV1S21JUFhEMlg1Q1Z1NnFsbTB1?=
 =?utf-8?B?M3VJY1ArbUx5OWtBUW9aL2VRZHlFVEVNbmNuTWJZZGphWXFYTzBIMG03OGZC?=
 =?utf-8?B?TlBLMHNWUTYweXdtelR5ZG5kTFNPR2VPNTNQbmo5QkM5aFdxK3Z4dStCdEo5?=
 =?utf-8?B?bS80OVhzK2pYTFd3MGVqZzVuTk9TMHpFY1cxNjFOTGxNbWhlempRNloyTyts?=
 =?utf-8?B?VjVTeTVZMmpFaFd0Q1NVelhmQXErY3B0MXVRWHBuVTdJMUsvN1Rkd2xFM25I?=
 =?utf-8?B?Um5JMnhvcm5wSm5iSTFCOFpsVDV6WFc5dWhZSmJjZTFsWEtRQVlNcFlPVmdq?=
 =?utf-8?B?NE5xbER6c1pramtvS3BJU1FQTnpVQmp5MlpZdEttSXpPWXpvaUhncXFBZUVk?=
 =?utf-8?B?V2R0dk5VcUxRTFJhc2hic0xuZ0dMeEZieUpISkR5VFJteFVUL3ovR3Jmblpt?=
 =?utf-8?B?SmRDa2NUU2RGY3haMzN4bEJZa3psRGRHTDQwQ2tZWDMxMG93QXYrTTdBeXBO?=
 =?utf-8?Q?/wbK6eiXseDWtGNp6CbZIDT7FopL+8MMgLHs/K7MS1egvy?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L080Z2ZxRWh0enVaZkprUGYxdm43NlZ6d2Ryd25FTFFLeXV3NUR3d1EwY2ph?=
 =?utf-8?B?a1FLdEVZdnhLSm8xTUU0VW0vNmE4YlJIK2xzOVZ4QWd3cVRKd0daMGZRVnJZ?=
 =?utf-8?B?b0RRdjM0aS9NbWZNMjVkKzFIRmd2YzNVOTVoZjdYZElPemwweDF5cVNLaWFT?=
 =?utf-8?B?TXRvdGxrdWJCOVYrTy94L3FoaTg5UXJVOVdGZVZQMlV2MEFFWDlFSnJHY2hB?=
 =?utf-8?B?VnlXakV1WmlGODhGeE95cWllYzVQczRRQldVTGo4L0V0V0dKRFRESjZPVnk0?=
 =?utf-8?B?U0xxVXB6U2ZreVBubkF5Y1VwTXpheCsvWjlzb2lGZUZZb3pyOExhQU5pVnI1?=
 =?utf-8?B?Z0JHOUdTVmNCaUFMMnZteFJNeVNnZnh3c1dXaEVZSlBVYWdiZ3U1dC9ka1BM?=
 =?utf-8?B?YlRYNEpSQS9lWFZRYlFPMmxSVGhaVUZOcEpubmdhcnRFdldsaFN0TnBiZ0xr?=
 =?utf-8?B?Y0s5d3JCdlU3ZkFiRmlKcWNYKy8xd0Q1L0JNRjluY01wcFV5RHBncHBhWlQ0?=
 =?utf-8?B?THREMzU3TzBPYjE5VXo4cEMyempTQldLOUNmem9rOUxJeGZWTmlWdkhHUWdy?=
 =?utf-8?B?dWREWVZJL3ZVUnRseGNLK2tNZzJ1dmNWV0dSMDB2OTVXQUovNEMxdm4xbENQ?=
 =?utf-8?B?Y0ZxNkRGNUhQc01yNlNPbndlcHVMQUVFc3htZ1JUMXBkQlNTUS9hTEc3RW9G?=
 =?utf-8?B?bXA1S25BM3J1WGhuYmR2NHlFRm9ZMy9MZ21TOHB1QlY2ZTFXL3hSNkZRT28y?=
 =?utf-8?B?TU1HbGdhU2F3MUx3T2QvZTdaZTRKUVpiU1hoV2NIQmVSeG5FbGZqekhIaWx0?=
 =?utf-8?B?Z202azF4R3J0Ri9PV2hET0k2UUt5c0NCbE5xRnZzdXRpaVQ3MVI4M0NURXJ4?=
 =?utf-8?B?N1p0bUVRcFhwV0wvZ2RtK2s5dGhNbzE5Z0Y4VGZ1alhaSEJTMG1JcFVmL2NF?=
 =?utf-8?B?SXZpaE9FL1NDYnk5eXU5eENRYWFPbStFcmhWNURGUjRhak1hTjVWUUhXSEx1?=
 =?utf-8?B?VTdtL25UOFpMSllMbkdlVk8yNXpGVW8yZmt5eDBNd280ZjdURkVqVmM0RFBX?=
 =?utf-8?B?S2FpWUI0ODZwZXJKSVdqRXd6R0JjNkd5M0JHVW9ETExlZlZTM2JOUTNjQ0FE?=
 =?utf-8?B?QWZncE9OVkcxc3Z5SllpY3k4emJlTGlHelFVSGs1V25jclBrM0RBMmUwOFJn?=
 =?utf-8?B?N1llRFZhZWVCMzBQSHI0NXJmNkpYY1IxNnNhNWhkd1JnOGJNUE0wdE94bm1M?=
 =?utf-8?B?UG0vdUhjY2ttdzJQSE13RWJXeHFIUUxwcUhXd0xoVFkxeGQ0Tk1sblRaNGNi?=
 =?utf-8?B?VThpdzRmOGhtL3VyYWZGbVlKSy9XZkcvWTNTclVzNExKZk1qS0F6UnBXVHNV?=
 =?utf-8?B?QlpHYnhua3R2a3BuN0hSVmxzdHFFRFJBWW9rN21tUGtPNFcwVU91dXpEOEdk?=
 =?utf-8?B?RFU5dHhQVldzVVBraVZFcWRYNWpMRXY0eTNnb3h2bDRqb01US3BXK0d0UnFr?=
 =?utf-8?B?MndiaVo0KzQrbUZvbWpRcFIxUlhFZUZpQ3pKbnd0UjdJWGMxdWNkazhFamZC?=
 =?utf-8?B?NzArMlNaZFI2Z3krSVc3UGd4bUtzejgrVisxbi9pTVdwVDVKUDVRQkdOaXFt?=
 =?utf-8?B?U2pWV2JQUWNlR1c0K0ZCTXoxamtQMVZ0Y0dvNHJEbkpDK1ZYem8xSmRoN0dE?=
 =?utf-8?Q?wSOSOYDZ+Sq/U5MPcs/k?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709eeffd-9854-4790-99e6-08de07c178e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 05:54:27.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9226

Hi Baruch,

On 10/8/25 20:08, Baruch Siach wrote:
> Hi George,
> 
> On Wed, Oct 08 2025, George Moussalem via B4 Relay wrote:
>> From: Devi Priya <quic_devipriy@quicinc.com>
>>
>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 44 ++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>> b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..1172f0b53fadc140482f9384a36020260df372b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm IPQ6018 PWM controller
>> +
>> +maintainers:
>> +  - Baruch Siach <baruch@tkos.co.il>
> 
> Unfortunately I have no access to this PWM hardware anymore. I don't
> think I can maintain hardware DT binding.
> 
> baruch

Got it, thanks. Will add myself as maintainer in next version.
I've tried contacting Devi too but got an NDR.

George>
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,ipq6018-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - "#pwm-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
>> +
>> +    pwm: pwm@1941010 {
>> +        compatible = "qcom,ipq6018-pwm";
>> +        reg = <0x01941010 0x20>;
>> +        clocks = <&gcc GCC_ADSS_PWM_CLK>;
>> +        assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
>> +        assigned-clock-rates = <100000000>;
>> +        #pwm-cells = <2>;
>> +    };
> 


