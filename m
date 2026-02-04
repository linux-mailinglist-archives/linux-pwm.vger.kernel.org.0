Return-Path: <linux-pwm+bounces-8084-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMEsEmQkg2k/iQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8084-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 11:50:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE489E4C5A
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 11:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80A54301629A
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68683B8BC6;
	Wed,  4 Feb 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SVHHNV+e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011057.outbound.protection.outlook.com [52.103.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF838F255;
	Wed,  4 Feb 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202066; cv=fail; b=cWGOo+Pw+GwZ7YNYjaXTJthw3Zjn5TqKQUc0qKFkNRk2PalKLH/ffAV/BDF6Efh1ntC+oXda2bQpq9U4zCjZyr41CzfTqP15SHL7d6w+3AK7lZ/YmiRpphRHZFyZXIYYXLuIA126UuRJYMuOYVXYMgnHSDqWN+xd+DP+JQmaJos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202066; c=relaxed/simple;
	bh=KxWjOea6W0VHoJFx73yH3Iw08DPsMZB+A1QiGzLdTX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYp+7d8LRei5XtoPX5Gs513VesUchIUyRm/c/AoBWIAP91TLkm5v5AH7H7Xz1wJR27DoAW4VZIJGxI/1LbVL6qROGlBrx+sEkyLKq5Phl7fqiJ632zPKPb6kxVr/j0GWjnwCxP8A8+8OEWfND2S7RIU29ajNJhAaqr3tR62OdRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SVHHNV+e; arc=fail smtp.client-ip=52.103.14.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VD345ALCm/yeD4xVzE3xgB3jO+2FKI/pg0iW3oHQu5Nx6yfp+XYlK9MLJNdNOVnLQ41l0WCL4jY1nUTd+bLJAXpuHEivHwLmy/7hD7PJ8s2yLINQ7/nNtKgZVdCRsgB7Kn0jYa+Lc0ynMWX0DuEz37BI99dE3semlTnOQz8vdh7x1M51BXr2ZcROTHRiYJArCOIwQbOqc1kB4i5g4fgQLHLxcq/oR4XWRNsNh2CYMfEbVa6LHYYZQ6oQ75hxNYB0+2QD+aHQ47IIDiDG2y1f1YFftcnUEyHeccuRERgCsXw0wtMpmDLNraQnEnO0uifEF+yvplN2FQFsSSsRCktf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNtwA4xf6B4nYLxhWvktB39cLXGcPyI4NQTAjn09oDc=;
 b=e7akpxX1lDzNynfYJ8V+W+RWEUFigamKZHVVtJm5KHkhEqOLmuVOrw95l/qYiuNR30pM15u8N9oGqOdWUaFhc3CL3OggHGznCsU5cO4+kTgcCxybUoHaYLWS6KWm+/v6mCGqszobIjVoBykYdDJnD/B/FRXCuOW3iEYnxv0BbL4zgm0qJRdYjV7BgWGA9jqFKDm0FxVGGafW5ekBwBXTD0dag4AtNWW33MsBICUzsQ3hE67nWCwlYXNq+g4dT19BycdVWncrrto5fi+GPW2d1w2PRDX+vChdyACosZGANTLEare6EcgiWGN2JtiU+2aExxliuUVzouZQ8EzofUG7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNtwA4xf6B4nYLxhWvktB39cLXGcPyI4NQTAjn09oDc=;
 b=SVHHNV+eTazC62krXhR6SC2Pz9X7oXqWn7QXuqdoCZ7mPB4vxxHekyX7XdQM+tpNL2xBLpPLgQBrSUN4cyuz6SM2a0dgaJIpz8gzZTBhPguwz9tPn/FWCXK8VuBvG4i2ksovUsxN1SHpLXd8dhDQpp2vzRUyfU6MjEdEYErYoPGHceWzvhDLERZhdXbJGVSabB0NSnS6MqWCt60aCAOpd/F7OTteTXAdgbVdh5xi+uON1lvqeWCKUDASpsAOlZLcy2iamdYRFl9dIEs2XU/eOxl9eAIF0KYmN2AqQ07NmrNY0SRx8mSvkgTQkBROl9uHavubO84MaPTptsfbC82ECg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DS4PR19MB9100.namprd19.prod.outlook.com (2603:10b6:8:29b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 10:47:44 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%4]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 10:47:44 +0000
Message-ID:
 <DS7PR19MB8883EC46B66736A0962FA3009D98A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 4 Feb 2026 14:47:31 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
 Baruch Siach <baruch.siach@siklu.com>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>
 <eajmwhwb2wd3ts4fpbu262uscqqddns3o5rf4b2jeswugpgmao@sdtx5hkqxz62>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <eajmwhwb2wd3ts4fpbu262uscqqddns3o5rf4b2jeswugpgmao@sdtx5hkqxz62>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0056.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <e7e52bae-e5e9-4a68-b0bd-2b6a34ec12d7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DS4PR19MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbe3827-2495-4637-a827-08de63dad30c
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFAyHke/CE1Ui/FW7barhRQEVpQlEYqH0vz4Z3DHM8R6tZ6YxNP/2L/X5PMn4YKbhUpOpnNPnUP9r6ojLBkczXtLyOAV49cW3Wb0bM1R7RMV/2NwZc+IB5Bl0dSBSZCJhgEgTD2xgPJntac8CXm/wKPM/rF5doDajCGBFnGXtiSMYrewGnHvWUttoDzDUTSO0QUjctG/Ntu6kH9+eLbmMODWR9EAW46B8s17SMnfiP3pTmF3MFBQY/ylbm2DF+oPvBcxsnEnuKD0wqJgsr5ENodjimaRB9n5yEpZCaXrupaS7O0E7MQtlnI5kw4EDjwekIdkYvBRQPsH1fJWIx+nkGQ6+Akdw5ONiztx0SuO53mpLVx5e/xAaByP+471X88Du+eF1dzB+2cUJ8Q9r7a0H+wVvsykMCiuApxIP8lgWigy6wjUq5OIYaq/fsbxQ6BQS6B8uZrnT9C8w8QbW6iO78RTOtWNTWPAMFji8tBWqKvsmJp2DNz6paASCkH6TPdKNHkoCzS9zC2T/MiQ3Keh2ser91YYg6fp2oko8Qgm4eVyiSftd5XBq+c4rxYtJwhkf8IywLHGhuLjPVpdULNft054g6F6TN0fqgkC9xhHJOBU7ReCCd69HLW/TtjzD0XGEvtwk/IjuiqXOQItZznjx/vr7m5fnT1IrIgZIsPekMn0k6T6nIp3kh2mrBbpVrC7hZ0Ppd1HDpiNKO6pZEfImCM2YcsOc2HVw4xkauGdt+e3xg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|19110799012|8060799015|41001999006|15080799012|23021999003|440099028|3412199025|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmZQdW0wWE9yQ2xJekowSEhYR3RocklGOWlQZEYrMXcrTHoxazduSzdGVUlK?=
 =?utf-8?B?R3I3dURZaUY5eHo1N1h5VjdtWkd4ZEMyanQzOWtQWXB1NEJDbDNub3JuQ0FV?=
 =?utf-8?B?QlRwUUE3T2dpM2hjb2NVZ1grWHFFVmpDY1lqamg1QWsvQUZCNzFobXczMElV?=
 =?utf-8?B?K1pscDhSaFJkWjZvVGx0WExvZHEvakZvM3VET2xSNXh5SFgxN3Q0akJ5SWpv?=
 =?utf-8?B?MFpvekNDUkJLSVJ1ekM5aEhYOGFocGU5dHROZFYwRzkvYXdhUUtuVTh5T3pD?=
 =?utf-8?B?bDBvWG9KUDhoU0ExUER4N05tT2JqNUJoMk1qM1phdEtIQ3B5bFZmWElkYnJT?=
 =?utf-8?B?NER6a0hkdHZRRWsxa3N4VTdCY0F3K0cxTTlCaXhqYjlDekgycmxPc2NrVUww?=
 =?utf-8?B?UmZEdXpNOXdlQk9XUW9XREMyZ1BQZ1RYME05QWtRcWc4bmUrY2o1dFNvdFAy?=
 =?utf-8?B?ZmozWWNXRVgrWkNQTFRQWFpyOGI4akdUMDZ3RlB0N1hOdXRoMy9ybWNzdERy?=
 =?utf-8?B?MGlrMHNxbGVIMG9sci9sL2hXUGdaMTNtTmZ1dHVpZVhBNDZZRXdpdUZLb0pm?=
 =?utf-8?B?ZTVPSW0wRzk2UlBqYU4zTTJBZytuN2lhdGQ1M1l0Tm83VlNwUjg3WmhHbnVT?=
 =?utf-8?B?OE1oV1ZGTUF0QW5scWZwRklSRDRzSEFzMlZnMWxCeXo3VU5FOTFyL0R1K1h0?=
 =?utf-8?B?bndzWWlXOVQxeUlnZno3WUVBUkYzZ2xhWHNhMTE4NEpNUTI1Y3U3YnEwLzBT?=
 =?utf-8?B?c1c1aVcyTHVVOHRNR1QrL1JiOVdacTI4WHE0ZEVod284Q2tZdmpOQ3p0TGlE?=
 =?utf-8?B?VnpqeE81VWE0TWMwb2VjMVFKT3pvQ3FYS0ErZGxISlEyMHIyMWRtSGxreEtu?=
 =?utf-8?B?eTgweDY1aVYwYjlrKzBoOW81ZFRvSVpCUkdIUDJ6bC92V1FVWFllOWQ5RUxJ?=
 =?utf-8?B?ZnFlK1BVd3VxeUNvcCs1djVJYzBBR2xraVVXOHV2MXBjQ2NoRXBtY05kYmVW?=
 =?utf-8?B?dW5yb3BHbVZralB3aDFPN3BGajhqMEhvTjV0VnZGSXRhK0JTT0xTZm9oc2VY?=
 =?utf-8?B?RzhObU1kS1VjM0EzKzcxNitVM0kyQzFQSnhQeWE1RXNtelFXT2xSOFJRdUox?=
 =?utf-8?B?ZnhON01OdWZ2N2dOWVRSOCsxQWFTdWtGcGQwQjUzL1poUDJNUVc3Q1JuZldr?=
 =?utf-8?B?R3Q4QUh5U2tWM1pKUlVVZEZDdGdGTk9ZWnJ5bDFhd0xjV05kcEx6enZ6eTk5?=
 =?utf-8?B?TDRGMTI1TmNWeUVSenJZVnQxVFdGQldYRjBPUjZEa0FKUVkrTlVZN0JnMWJB?=
 =?utf-8?B?Nk9mS3lEc1k2K2krd3FDY0hjZmlHbE9qWXljeWh4Wk15L3Bvcm9EQlY2WlAr?=
 =?utf-8?B?NnA3YlZTaVV2cEJzV3hqdGdKNkdYWFZUR3YvSFZRQUprWTRtYUVaT2c2WFdm?=
 =?utf-8?B?N2ErbzE5V3JYYzRNTmROdTdOU2FMdFdmam9QcGpNdURDTUtEMVZYWUMzZ2lQ?=
 =?utf-8?B?bXYzcjlPRlpUM1crYkJHRDVObHZUYWJmdDEzZXZtZmxlaFFabHYxNDgremVV?=
 =?utf-8?B?eWpiZnhyc25qWE01UGNDOVhUQUZUVXZEUno0VElmdnBWbTZnSlJmQXZzaHNR?=
 =?utf-8?Q?9R7AUsGVkxbULThfWbcyhjt5J73j97Y3E3oB8R60u2AA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWprZHNDOGMva0ZoNU5oL2kwWE05Y0NYL0hlUTZvTEJRU1laeGZnaHZFYVVk?=
 =?utf-8?B?ZWFRL1FKUnB3S2xFamVVV3duWklnMmV0Q2FzbEdpZzJvL24xVzdIeHl4MTcx?=
 =?utf-8?B?aHprem8xd2E3M1VSWWRyWk8vSXBsSWNEcm0xRzdjMldyR0Y2TmJEU3N5a1JK?=
 =?utf-8?B?dE56M2EycE83dGxrZk5IZWh4MFRJckZMM1BucExPeTdUd2M1b0pnamY2c05O?=
 =?utf-8?B?SmpNTHBOWHUwTUhRbEoxenBRYm1vT1NST0tMU0VVY0crUTM5V0x0SkduZVFO?=
 =?utf-8?B?YU5VMWhZSFlpZndZNmJVaGx5ei9KU25wVER6UkthbXlhQVhXQ213L1NEZUQ1?=
 =?utf-8?B?VitqdkpwMXhRTmU4V1h3VmE3RnBLMjNyMVFHdFJpaTh0Y1VsTlk2ME13anFw?=
 =?utf-8?B?VklibmNaSWw0M3lZVWpuZ1lSQkpGS1M0TUhDM1ZPakxDY1paS2taOFdBejNO?=
 =?utf-8?B?Tmxab2tqZjZpUTZUbjhiZDZFeGxrUCtZeE1FdlQ4M0ZLdUFPcWx0ZkxtWFNU?=
 =?utf-8?B?THpTZ1JSYjk3RjRpU0kyQ3c5QkxJUjVpdUpCZzg2R2Z4TjROdDBuQlNUK3Rh?=
 =?utf-8?B?Wi9rUHQrUFAxK0VRaUlwZU9STUFFNHo5N256Nk5zeVhhYThVVjZxOThzSmJO?=
 =?utf-8?B?QVZ3UEUzcit0eTMrUHRpbzY1K1YrSzJJRWxaSEZEczZNaVdjN3dpSERQbUVQ?=
 =?utf-8?B?QlZhbXgyb0w3UnhjUDJzNi93Uzd1UkY2ckN5MzdxUVRKOE45NEw3M1VRNlkw?=
 =?utf-8?B?bDBLaHMybGtaUU1qR1JzaDl4YTNpajZKdnd3TWNJbHlvdmpHMU0wN0ZiWVBB?=
 =?utf-8?B?dXFvK21mZFRneTlpUW5QNFBBaklqZXprbWJLcmJCdEZ5REVXdno4d3M1by8w?=
 =?utf-8?B?a1NRenNLT1JmOU4vcnlIaGRaV1BzeU1DaW0yNVJuV0trNk41RUV2T3NzMmJa?=
 =?utf-8?B?RzAzaGVCNXlSZkpTR0h2c2pWWklac0NqSmNSSmx0S0dNMHJQdGVUb0p6RHR6?=
 =?utf-8?B?am05cXVUc0QvREtjSlBIN1NNb3l6ZkI3S1RCYzhMM1ZoWDFUVWdydklhZFk5?=
 =?utf-8?B?dUhhVklpYWZRYXg1d1pjMHBiaE1QdFRmbFI0aDhFT3hrS3BTTUxpekU3ZDZJ?=
 =?utf-8?B?enplRUhTZW9jNjhKRXR2cEJtcEhLS281Y3dmR0ZieTc5UkxWc2lFYVZwQmxq?=
 =?utf-8?B?SmRjeEhVaVFjOGpEamJLeFpRQzFEQjRMeEVkL3RpcUswUGhEdGhZOWpIV0xu?=
 =?utf-8?B?azJzVlBYQThNdHc0QUthR1gyQjFzM1BDZWhjelJVWW1uTU5EMmZnOU0zOWpv?=
 =?utf-8?B?WXRrRFpodjVtUjFpbzB6d2JEMkhSelV1NGNVYjVCbjIwU1BVeWxpc3o1MllL?=
 =?utf-8?B?enh5U20xSGc4KzlwaS9uUXpxMFR1b1Y0di85aXZiMEViangyM1BET2pwUkVC?=
 =?utf-8?B?VHFQdHV5V1lXY3loM2ZMK3pTaHZ2Vy92cXlJOUljZ1VpcTR4NHJneFZMYTBm?=
 =?utf-8?B?d0t4ZWFudGFBT252clZ0d2VNamg2emVmNzZzMDRFNitXMUhYV1JWNmpMUGhI?=
 =?utf-8?B?aitPcE1EeENpTGcxdmRwSmt4aDBUbFl6VndYRG9GZElPcGplWWF1Rno2TjRt?=
 =?utf-8?B?ZytvMW9aNSt4L09kNDkyVXg1UkkxcjB6REh2M0VWdFVBUlVIY0c4cEhrZ2Fn?=
 =?utf-8?B?c29lM0dpSWxLYW5RNFZTVzIrK3NrYUt3b2R3cUpHMlZPQXRRN1MyNjhIVVFD?=
 =?utf-8?B?dDFPMzdvTlFzQmNneDk3QWE3akpmOEdub2tZQy9EQUlINXpBck4yN3Vub2JJ?=
 =?utf-8?B?WjBkS2dIS2hPNTBKemRZYnk5WXlGMlUzVTlFOWxsTVdDdXduYnVuME0rNENp?=
 =?utf-8?B?UGNndHd2NHdUd2lXaXBoKzBsUzlLSjhRTzlNeGNJZC9Fd1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbe3827-2495-4637-a827-08de63dad30c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:47:43.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR19MB9100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8084-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_MUA_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,siklu.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quicinc.com:email,DS7PR19MB8883.namprd19.prod.outlook.com:mid]
X-Rspamd-Queue-Id: AE489E4C5A
X-Rspamd-Action: no action

Hi Uwe,

On 1/19/26 20:30, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Nov 28, 2025 at 02:29:14PM +0400, George Moussalem via B4 Relay wrote:
>> From: Devi Priya <quic_devipriy@quicinc.com>
>>
>> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
>> driver from downstream Codeaurora kernel tree. Removed support for older
>> (V1) variants because I have no access to that hardware.
>>
>> Tested on IPQ5018 and IPQ6010 based hardware.
>>
>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>> v18:
>>
>>   Added hardware notes and limitations based on own findings as
>>   requested. NOTE: there's no publically available datasheet though.
>>
>>   Expanded comment on REG1_UPDATE to indicate that when this bit is set,
>>   values for div and pre-div take effect. The hardware automatically
>>   unsets it when the change is completed.
>>
>>   Added newline between MACRO definition and next comment
>>
>>   In config_div_and_duty, used mul_u64_u64_div_u64 to avoid overflow
>>
>>   Removed unncessary restriction of pwm_div to MAX_DIV - 1 after testing
>>
>>   Constrain pre_div to MAX_DIV is pre_div calculated is > MAX_DIV
>>
>>   Use of mul_u64_u64_div_u64 in .apply
>>
>>   Skip calculation of period and duty cycle when PWM_ENABLE REG is unset
>>
>>   Set duty cycle to period value when calculated duty cycle > period to
>>   return a valid config
>>
>>   Removed .npwm as it's taken care of in devm_pwmchip_alloc
>>
>>   Added call to devm_clk_rate_exclusive_get to lock the clock rate
>>
>>   Start all kernel messages with a capital letter and end with \n.
>>
>> v17:
>>
>>   Removed unnecessary code comments
>>
>> v16:
>>
>>   Simplified code to calculate divs and duty cycle as per Uwe's comments
>>
>>   Removed unused pwm_chip struct from ipq_pwm_chip struct
>>
>>   Removed unnecessary cast as per Uwe's comment
>>
>>   Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
>>
>>   Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
>>
>>   Removed .owner from driver struct
>>
>> v15:
>>
>>   No change
>>
>> v14:
>>
>>   Picked up the R-b tag
>>
>> v13:
>>
>>   Updated the file name to match the compatible
>>
>>   Sorted the properties and updated the order in the required field
>>
>>   Dropped the syscon node from examples
>>
>> v12:
>>
>>   Picked up the R-b tag
>>
>> v11:
>>
>>   No change
>>
>> v10:
>>
>>   No change
>>
>> v9:
>>
>>   Add 'ranges' property to example (Rob)
>>
>>   Drop label in example (Rob)
>>
>> v8:
>>
>>   Add size cell to 'reg' (Rob)
>>
>> v7:
>>
>>   Use 'reg' instead of 'offset' (Rob)
>>
>>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
>>
>>   Use single cell address/size in example node (Bjorn)
>>
>>   Move '#pwm-cells' lower in example node (Bjorn)
>>
>>   List 'reg' as required
>>
>> v6:
>>
>>   Device node is child of TCSR; remove phandle (Rob Herring)
>>
>>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
>>
>> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>>     Andersson, Kathiravan T)
>>
>> v4: Update the binding example node as well (Rob Herring's bot)
>>
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>
>> v2: Make #pwm-cells const (Rob Herring)
>> ---
>>  drivers/pwm/Kconfig   |  12 +++
>>  drivers/pwm/Makefile  |   1 +
>>  drivers/pwm/pwm-ipq.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 252 insertions(+)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index bf2d101f67a1e0ae12a58b5630abd5cfd77ccc99..6393f4e91697ae471b1aba72e7ef3f94c5e18383 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -347,6 +347,18 @@ config PWM_INTEL_LGM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-intel-lgm.
>>  
>> +config PWM_IPQ
>> +	tristate "IPQ PWM support"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on HAVE_CLK && HAS_IOMEM
>> +	help
>> +	  Generic PWM framework driver for IPQ PWM block which supports
>> +	  4 pwm channels. Each of the these channels can be configured
>> +	  independent of each other.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-ipq.
>> +
>>  config PWM_IQS620A
>>  	tristate "Azoteq IQS620A PWM support"
>>  	depends on MFD_IQS62X || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 0dc0d2b69025dbd27013285cd335d3cb1ca2ab3f..5630a521a7cffeb83ff8c8960e15eb23ddb1c9f8 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
>>  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
>>  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
>>  obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
>> +obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
>>  obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
>>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>>  obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
>> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9955b185bc60f27d770f3833d5acd7f587595324
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ipq.c
>> @@ -0,0 +1,239 @@
>> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
>> +/*
>> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
>> + *
>> + * Hardware notes / Limitations:
>> + * - The PWM controller has no publicly available datasheet.
>> + * - Each of the four channels is programmed via two 32-bit registers
>> + *   (REG0 and REG1 at 8-byte stride).
>> + * - Period and duty-cycle reconfiguration is fully atomic: new divider,
>> + *   pre-divider, and high-duration values are latched by setting the
>> + *   UPDATE bit (bit 30 in REG1). The hardware applies the new settings
>> + *   at the beginning of the next period without disabling the output,
>> + *   so the currently running period is always completed.
>> + * - On disable (clearing the ENABLE bit 31 in REG1), the hardware
>> + *   finishes the current period before stopping the output. The pin
>> + *   is then driven to the inactive (low) level.
>> + * - Upon disabling, the hardware resets the pre-divider (PRE_DIV) and divider
>> + *   fields (PWM_DIV) in REG0 and REG1 to 0x0000 and 0x0001 respectively.
>> + * - Only normal polarity is supported.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/math64.h>
>> +#include <linux/of_device.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/units.h>
>> +
>> +/* The frequency range supported is 1 Hz to clock rate */
>> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
> 
> This is used below with:
> 	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> 
> Where does this limitation come from?

Tbh, I don't know, it was added by qcom, I took over from v16 onwards
and I don't have the technical datasheet / specs. Perhaps Devi or Baruch
can chime in?

I've got v20 ready and will submit as is if that's okay.

> 
>> +/*
>> + * The max value specified for each field is based on the number of bits
>> + * in the pwm control register for that field
>> + */
>> +#define IPQ_PWM_MAX_DIV		0xFFFF
> 
> Maybe use (depending on context) FIELD_MAX(IPQ_PWM_REG0_PWM_DIV) or
> FIELD_MAX(IPQ_PWM_REG1_PRE_DIV).

Changed to FIELD_MAX in next version (16-bit)

> 
>> +
>> +/*
>> + * Two 32-bit registers for each PWM: REG0, and REG1.
>> + * Base offset for PWM #i is at 8 * #i.
>> + */
>> +#define IPQ_PWM_REG0			0
>> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
>> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
>> +
>> +#define IPQ_PWM_REG1			4
>> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
>> +
>> +/*
>> + * Enable bit is set to enable output toggling in pwm device.
>> + * Update bit is set to trigger the change and is unset automatically
>> + * to reflect the changed divider and high duration values in register.
>> + */
>> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
>> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
>> +
>> +struct ipq_pwm_chip {
>> +	struct clk *clk;
> 
> you're using clk_rate_exclusive_get(), so it's enough to call
> clk_get_rate() once. Then you can store the rate here instead of the
> clk itself.

Removed clk from ipq_pwm struct and added unsigned long rate field which
is set during probe after enabling the clock.

> 
>> +	void __iomem *mem;
>> +};
>> +
>> +static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
>> +{
>> +	return pwmchip_get_drvdata(chip);
>> +}
>> +
>> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned int reg)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
>> +	unsigned int off = 8 * pwm->hwpwm + reg;
>> +
>> +	return readl(ipq_chip->mem + off);
>> +}
>> +
>> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
>> +			      unsigned int val)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
>> +	unsigned int off = 8 * pwm->hwpwm + reg;
>> +
>> +	writel(val, ipq_chip->mem + off);
>> +}
>> +
>> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre_div,
> 
> Missing name prefix (i.e. rename to ipq_pwm_config_div_and_duty(), or
> maybe even better: fold into ipq_pwm_apply()).

Addressed and folded into .apply in v20.

> 
>> +				unsigned int pwm_div, unsigned long rate, u64 duty_ns,
>> +				bool enable)
>> +{
>> +	unsigned long hi_dur;
>> +	unsigned long val = 0;
>> +
>> +	/*
>> +	 * high duration = pwm duty * (pwm div + 1)
>> +	 * pwm duty = duty_ns / period_ns
>> +	 */
>> +	hi_dur = mul_u64_u64_div_u64(duty_ns, rate, (pre_div + 1) * NSEC_PER_SEC);
> 
> With pre_div = 0xffff the multiplication in the 3rd parameter overflows.

cast to u64 during calculation -> mul_u64_u64_div_u64(duty_ns, rate,
(u64)(pre_div + 1) * NSEC_PER_SEC)

> 
>> +	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
>> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
>> +
>> +	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
>> +
>> +	/* PWM enable toggle needs a separate write to REG1 */
>> +	val |= IPQ_PWM_REG1_UPDATE;
>> +	if (enable)
>> +		val |= IPQ_PWM_REG1_ENABLE;
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
>> +}
>> +
>> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
>> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
>> +	unsigned int pre_div, pwm_div;
>> +	u64 period_ns, duty_ns;
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
>> +		return -ERANGE;
>> +
>> +	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>> +	duty_ns = min(state->duty_cycle, period_ns);
>> +
>> +	pwm_div = IPQ_PWM_MAX_DIV;
> 
> With pwm_div = 0xffff you cannot configure a 100% relative duty cycle,
> right?

Fixed in next version.

> 
>> +	pre_div = mul_u64_u64_div_u64(period_ns, rate, (u64)NSEC_PER_SEC * (pwm_div + 1));
> 
> according to the get_state() callback below we have:
> 
>             (PRE_DIV + 1) (PWM_DIV + 1)
> 	P = ---------------------------
> 	                RATE
> 
> The (first) +1 isn't accounted for in your formula.

thanks, fixed in v20.
> 	
>> +
>> +	if (pre_div > IPQ_PWM_MAX_DIV)
>> +		pre_div = IPQ_PWM_MAX_DIV;
>> +
>> +	config_div_and_duty(pwm, pre_div, pwm_div, rate, duty_ns, state->enabled);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			     struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
>> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
>> +	unsigned int pre_div, pwm_div, hi_dur;
>> +	u64 effective_div, hi_div;
>> +	u32 reg0, reg1;
>> +
>> +	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
>> +	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
>> +
>> +	if (!state->enabled)
>> +		return 0;
>> +
>> +	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
>> +
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +
>> +	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
>> +	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
>> +	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
>> +
>> +	/* No overflow here, both pre_div and pwm_div <= 0xffff */
>> +	effective_div = (pre_div + 1) * (pwm_div + 1);
> 
> With pre_div = pwm_div = 0xffff this yields 0x100000000 which overflows
> a (32 bit) unsigned int.
> 

fixed in v20.

>> +	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate);
>> +
>> +	hi_div = hi_dur * (pre_div + 1);
>> +	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC, rate);
>> +
>> +	/*
>> +	 * ensure a valid config is passed back to PWM core in case duty_cycle
>> +	 * is > period (>100%)
>> +	 */
>> +	state->duty_cycle = min(state->duty_cycle, state->period);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops ipq_pwm_ops = {
>> +	.apply = ipq_pwm_apply,
>> +	.get_state = ipq_pwm_get_state,
>> +};
>> +
>> +static int ipq_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ipq_pwm_chip *pwm;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	chip = devm_pwmchip_alloc(dev, 4, sizeof(*pwm));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	pwm = ipq_pwm_from_chip(chip);
>> +
>> +	pwm->mem = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pwm->mem))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->mem),
>> +				"Failed to acquire resource\n");
> 
> Please align continuation lines to the opening (.
> 
>> +
>> +	pwm->clk = devm_clk_get_enabled(dev, NULL);
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
>> +				"Failed to get clock\n");
>> +
>> +	ret = devm_clk_rate_exclusive_get(dev, pwm->clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				"Failed to lock clock rate\n");
>> +
>> +	chip->ops = &ipq_pwm_ops;
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
>> +
>> +	return ret;
> 
> You could return 0 here which is a tad clearer.

Done.

> 
>> +}
>> +
>> +static const struct of_device_id pwm_ipq_dt_match[] = {
>> +	{ .compatible = "qcom,ipq6018-pwm", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
>> +
>> +static struct platform_driver ipq_pwm_driver = {
>> +	.driver = {
>> +		.name = "ipq-pwm",
>> +		.of_match_table = pwm_ipq_dt_match,
>> +	},
>> +	.probe = ipq_pwm_probe,
>> +};
>> +
>> +module_platform_driver(ipq_pwm_driver);
>> +
>> +MODULE_LICENSE("GPL");
> 
> Best regards
> Uwe


