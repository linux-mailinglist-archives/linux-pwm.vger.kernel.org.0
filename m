Return-Path: <linux-pwm+bounces-8943-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMItAXF/Cmoo2AQAu9opvQ
	(envelope-from <linux-pwm+bounces-8943-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 04:54:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4056531C
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 04:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD7BE3001D67
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 02:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C537BE84;
	Mon, 18 May 2026 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Msj9TO4g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023096.outbound.protection.outlook.com [52.101.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF33405C4D;
	Mon, 18 May 2026 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072878; cv=fail; b=pqEV9Ra/FzoPnXWEaeNgIbLBtDQ4PoL/zJQ7zpPZVFPmuSAajUMNuLrI6jig6/vFKn9XtR7BxmrKYE4Ap9O81MzZLlb6DhwQcbXwaW+5ucpXP8t8KK5AN2XZ6P0wykr+SaZiCZlo/LBZAdlseGKZkUpMvkAmWit6hScLmNS25UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072878; c=relaxed/simple;
	bh=g4EucsF+aseONSVKq2xOexdgOi0CDybclUgoAJvXyiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBDR6srIqzSpgNTRkP/CJHFa42ICEQ68EtVebIb+J/FukSYuMmmfmZVbtLmM3rynC0XDb7lRY/A+1559Uj/8vPNjI7Qy/qQOX+C4zZxGxFR46hBtewIXA+p2yJStmW19jMfZLeHUHxixIS2fvcyZOX7hd2IjyZDBHmpjvndy3BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Msj9TO4g; arc=fail smtp.client-ip=52.101.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiIcVhnhdkFWINmWUgM3j6FIUawBoBzWXs6cgkxTdSsYmMtpXOY/8q78kVTmExQuSSe1JFFo5Tk/dW8UMKk4cpBm1ktWRe/ZQH287T2Wc54YmPiAF76dIa8K7tw+PuOgYQ0Yti/VQjBj1aCsT+KisEBEggmoVOiGX9uiPQ9m9P+3OnKqpJdI2zUStaXEyF6BxWahsBcXbBRml3V5k9U97zk39krih/k76cmpz/xNJGL/UF3g/PXHy/ujo5n+rrFASfZp2wE5AwR2EIKDFNPOloshJHlBAZoPdHtLOk+WW8CmA56Oinhrdzc8zy2yjBBAo6UQ2SftMZ5cn7eX1rlU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSGaZm4Tq2uCXDKeeZWZG9xlQuzya7ogrnCfCnJNTEA=;
 b=TLr396FioqlNWEzzvSzAePBfegMwRL99WsZa9NhwUHO3Smj55WZauxjJMMxWwOH2x7Vhx9wFFHa372EmoIFfb0lE5QR5PV4EcexvAzOq7kSJkZO058gv09uH1mu8TKhG4+/Pudw3Vv0eFxzDWrD26fnXQ112gPp6sQs06v04O7qk7pwmMYpTTTOT36ReeKfo+ZlyiPQ2ZLoVG9cbA29UBFSIqibES3e+xYgU6raDYbO3rh1EfHjvJZ7rARJWll/NEFg9M8e8F7cNfHINsHpNlLxv7avz5MY19DSAVRNMPmFmXLgC52K7KobcpYjGhCS/HyOzqaOHOSrw2lzDxUtNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSGaZm4Tq2uCXDKeeZWZG9xlQuzya7ogrnCfCnJNTEA=;
 b=Msj9TO4gCOUOsTKZcNwa7HXQf2A0yKnFmfFCC6oeEg2QWDZv5kv79wLZgfAl+XFYhouUdejXNtK6FUIDU6kly4PhftgziRv1/EmK7n3xfIpatWXBFBIGeHwxCWkXsECAWXZvzFobkksOj185nVXy6mMO7R4xr/H2VycxxfEtD/et3xYDf+2xXnPVNyM/hwAeyq45O0tYKJxD8ySp4O3H9kTREV0RUMSNZXDK5gmCKT22A5GGEzG9+iAK+yrv3ZcEj4LZxOqvRdYKSy6EyVKAcroDFmTowRFsq8zYUoIKbze1761m6pIDmgEwmrojvhQhuGg853cT6wrpNwsVyV1S8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SE1PPF608CA1C66.apcprd03.prod.outlook.com (2603:1096:108:1::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.16; Mon, 18 May
 2026 02:54:32 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.21.0048.010; Mon, 18 May 2026
 02:54:32 +0000
Message-ID: <20ce87e8-eaf5-4e64-bb48-c56f33001c47@amlogic.com>
Date: Mon, 18 May 2026 10:54:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: meson: Add support for Amlogic S7
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com>
 <20260402-s6-s7-pwm-v2-2-657dce040956@amlogic.com>
 <agn2Yp3mzI7DcsyN@monoceros>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <agn2Yp3mzI7DcsyN@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SE1PPF608CA1C66:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d82ac1e-2d58-41ce-2840-08deb488c97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	H0lYnRyjA9aUOpu8+yqIWqFOKe6XaXMudOLy2Tke7eNmORa17Jf3ftYByPw4UXiNMA5rnJotKZEWY9MPiGC9zMddOIe2eUS5V3xHnIF+FIIe02y0r7Sr/PT6UbWVHJAPp8v13DEDlu5qZd2lt9BJzdbp1/BG2fRqL8Q+Xa9kB4eI0KvrxkveGfGlJlUxjw40wnqz0oBkIuQv0gdXG52OpNYL/oB8N+yYJNrSrKQtMzZ/P598QpVTSbVvi6lLdJjSkjMaIXus/dTsMHhVEpydOUnlu8jQT2GNUTzDFyvLCN6FSoMZnmRpsxwoiZ/9xT9bhL/jVN9DyR/wStcVgF+TBdqQ2BFDsTUrbNBeKym4l60i1Xyc8RCkOa8gZWuvpkQgnnG1yedleCYdeI5Mhp8VLVSj11KrA+bWlyhu6sb/DGBN9kBBzQVn8k+7L2yZwqwo0BraICZKcKdPlaRjrJZq867RfCbO5R9NLFABj5gtevqOD/LFS598sOxiESSQIByqy5S8c+FXRp+M8u0e9kSVX/20fL6nb1Pd8LD7tFm9WC6rJQq87mBpx1UVEynZUYgE1YYhh2B2Vz30azPMz/8iDrYQLul8yKLo03iJUpMrFucFI+wzTDi4Ginh1AAA7ghW2IHjdm9kDUOwUcToaUH/Zp6XeQBL72/Cacezc6kdH4X3bkoORKARHGENLhIHfewq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lrb0dJeDY5VzlMMkFzYWoyR0o0b1pjZE5PYlg2VVhPZWxDdklwamxpL2hS?=
 =?utf-8?B?VDFBOHNlc2tMb1FFVEJMOVJzU3FjRmRyQlJZLzJrT3VNcXF3NmtqR3F1bklp?=
 =?utf-8?B?K0ttY0t5clh4Rk5tRFlYVTNPOGZBWHNackhGM09zQWZyUm9GWExnaXEvQTRL?=
 =?utf-8?B?M2lzRW1GbUVIKy9aT2lhaHp2VzU3T3E5UnFvWHRXeTZZRDFHUURYWEN2bzlK?=
 =?utf-8?B?TXlvUER4b0Z2UzRTZUhlVHVmUHNLSnZCR1ZUa1Y1eWtzejYyd21aN3RCRjdi?=
 =?utf-8?B?Z1VBbSt3QnpxK2ltWG5YQU9oZ3NwMVFWdy85andHaS9nSzYwRENwMGZpNDBF?=
 =?utf-8?B?OVR4N01qNTdrQm1WYmF4M0JGelBSRE4rR2JranJnZWgxdU9zdXd4WHlLc0Y1?=
 =?utf-8?B?TStKdzVLbGszN0RaT29MTjE4b0l3OW40VU1URHh6bmVTekpqcXJQcUVVMG41?=
 =?utf-8?B?NmUrOTBWamtMNTdRQ21oWUI2TVVNdjlMNkIvL1dkaXp2M3Z4QmtjeDM5MTQ4?=
 =?utf-8?B?NVpuSnpTci82d3lvUDZDZENoWlozNGY4Q2cvcENFVURnUWROTHdUZlRhaWh4?=
 =?utf-8?B?YmxHYzlOem4zdllxSzdQMWg0NW9EMzFaaTdVYkE2VnRCTjZNdDZNWjUwWWZ6?=
 =?utf-8?B?SDE2VFFIZXh2YlFLYTk4bUJnUWRpK3JMV29yRC8zSVVVSUxCaHNKblBPWHhl?=
 =?utf-8?B?TFErTWRFNmVYY2VPcVk5SnZCVmdqdUFCNEp3YXJlbEl3aXp3WmZjYmZvOWZG?=
 =?utf-8?B?SnBHWExKS2xCVG05SUx4TkcvL2MrTDBsOVFDSVl1TDUzRml6ZVRya0RIQ3BQ?=
 =?utf-8?B?eUUxTG0zSytBeWpHakNLSENmRExYRXNENENxNjBGMHUwa25tWTBHSEVXUE4y?=
 =?utf-8?B?ejZveHlmeGswdUdBVWVpQzNlT1NoUDhWVjF5RFpETWN3dFpnZVU1NFZRWVh5?=
 =?utf-8?B?TmZmSS85RWZHUFFoYVNmM2NrT1RNanpGZHliTk0rRjN0YjhVT2craDVFZGVI?=
 =?utf-8?B?VHVpYWJ5T29JTTRkWHI2aXNBbE4xZFpwYmdNWm9RYVB6cE9zL29pYjE3YnFV?=
 =?utf-8?B?WmNqZThTNFJuNlQ0dWF5RHdRUHl4SWJwaVhHTXNLdnpRcUV2NVlUYUZlT3Rr?=
 =?utf-8?B?S0tabTBlV2FMVFMvZ3Qya2s5L2FPRU9yK2ZlSnM0ZEJvVmdETjNuYWgyWmxa?=
 =?utf-8?B?eWZZUVZlaTN4cjhtQWNFZHB0RHZocG1VTTM1WWRNNUczMjVXQmM1eDNhL3gy?=
 =?utf-8?B?b1JMOEdLTTFqY08vWGhaQ2RMT0U5U295OFpDYWdldnYxVDVCZjNxSGRUVXBP?=
 =?utf-8?B?aUZrR25YeVNDQkFUSHBVQWM3UmlhU3Z4TE9zSWUvV1V3SFk5RjJZend2K2hJ?=
 =?utf-8?B?V3ZIZnB0TE5ZN2ZDZldIVExyNXJBcnR1Q29qOTBEeDlIVzJYSGhaTVY4QTBW?=
 =?utf-8?B?aTFGenQ5MVhHNit4SE1oejM4UEZCbGhTbEh2Zi9qQmxMOEVhS09PT1A5bGpK?=
 =?utf-8?B?OGpKZkNISXYyOXlyMFZFRjBoY0s2YXArQ245TWxYS1g2MUt5OHk5VnN5UFFt?=
 =?utf-8?B?TG9WeU1BMklJeG5FWWVQZWREZThRL2ZqTUVYaGJZK0dHc2VGczlEOFNTWVVZ?=
 =?utf-8?B?MzhQSU9peW83Tnh2Ykl4YUJzQnBNQVNVQjZUOEpZNk15SUp1RWszQ1JTcGtQ?=
 =?utf-8?B?eGtScVVVYytPbTZ6Vmw0cllMMTBoY3dlcExFWHhpeFZuN1ZUVUUyYTc4WGMz?=
 =?utf-8?B?dlNtQzV5WC8xYW9xYXNWNEdsMWxsL3FxOC90UEp6bWkvRGF4cmJvaGFBUXVi?=
 =?utf-8?B?ZFhRU2tES21HajFpS054RER3S1lVQVhZRHhabVhuSVZ1Q3ZlUWNXVFhZSnpC?=
 =?utf-8?B?Y1h6eTBUOWNRQm13VURhcEtPTzBiRXFaYkhSQWIyTXJhOXZUcjFCZUdyOEt0?=
 =?utf-8?B?NTd6Y2poZmVHN2lHSWpOMVZaVUx2YkYrWFBUdklXM2lZWE9zNW9pd1ZWUnFQ?=
 =?utf-8?B?N092dEc3YytoanhlMjdsWmNwUW8rYWgyS3NOSkpzeVh6MmU0em10RUV6U3NB?=
 =?utf-8?B?RFowQkw4MzdOM3BMK0JVTHlBdFdES3g2dFZ1KzJldUJ3azU4YllpQlFhVFdE?=
 =?utf-8?B?dkZGbVAvK0twZTBLajlnd2NnVDBwdmxiR2FEczErSnZPclJSQ2t3ZnM4TDRk?=
 =?utf-8?B?SHdkM09sWFpmbVozc0ZPQ01xVGtDa1M4dVVaV1FOMjduQnBMWTI2VFNnSmhC?=
 =?utf-8?B?K2VHU2tiSDNUMlV6QjRiVXFyZ01VcGVzVU5SM1AyUld5RVZZT0NzcFVkYnRS?=
 =?utf-8?B?bkxWS3p2eEh3TG4ycTFLS2F0Yk8ya0g2ejJQOE44eWNYU0xpcnE3Zz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d82ac1e-2d58-41ce-2840-08deb488c97e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:54:32.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqqogjTyRKuaTrPW6OgDZ0PZVNAtcAGk3MlcAm0JMuwiRVVE7KUc0K3SMAjtj94fLjflRRKh2GKhXnmpT/3Gy+0zPyShpZJR8eryRruDOPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF608CA1C66
X-Rspamd-Queue-Id: 9CD4056531C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8943-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Uwe,
    Thanks for your review.

On 2026/5/18 01:12, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Apr 02, 2026 at 02:40:16AM +0000, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Add support for Amlogic S7 PWM. Amlogic S7 different from the
>> previous SoCs, a controller includes one pwm, at the same time,
>> the controller has only one input clock source.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 8c6bf3d49753..7a43c42ef3d6 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -113,6 +113,7 @@ struct meson_pwm_data {
>>   	int (*channels_init)(struct pwm_chip *chip);
>>   	bool has_constant;
>>   	bool has_polarity;
>> +	bool single_pwm;
> Conceptually I'd prefer a `npwm` field here. That doesn't take more
> space in memory and simplifies the logic a bit. (At the cost of having
> to adapt all already existing meson_pwm_data instances, but that's fine
> in my book.)
> 

I will use npwm(u8) instead of single_pwm.

>>   };
>>   
>>   struct meson_pwm {
>> @@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
>>   	clk_put(clk);
>>   }
>>   
>> +static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
>> +{
>> +	struct device *dev = pwmchip_parent(chip);
>> +	struct meson_pwm *meson = to_meson_pwm(chip);
>> +
>> +	meson->channels[0].clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(meson->channels[0].clk))
>> +		return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
>> +				     "Failed to get clk\n");
>> +	return 0;
>> +}
>> +
>>   static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
>>   {
>>   	struct device *dev = pwmchip_parent(chip);
>> @@ -592,6 +605,13 @@ static const struct meson_pwm_data pwm_s4_data = {
>>   	.has_polarity = true,
>>   };
>>   
>> +static const struct meson_pwm_data pwm_s7_data = {
>> +	.channels_init = meson_pwm_init_channels_s7,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>> +	.single_pwm = true,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>   	{
>>   		.compatible = "amlogic,meson8-pwm-v2",
>> @@ -642,6 +662,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>   		.compatible = "amlogic,meson-s4-pwm",
>>   		.data = &pwm_s4_data
>>   	},
>> +	{
>> +		.compatible = "amlogic,s7-pwm",
>> +		.data = &pwm_s7_data
>> +	},
>>   	{},
> If you touch that array in the next revision, please make this line:
> 
> 	{ }
> 
> (I.e. add a space and drop the comma.)
>

Will do.

> Best regards
> Uwe

