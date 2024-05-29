Return-Path: <linux-pwm+bounces-2290-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C568D3430
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879251C240C8
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009018130F;
	Wed, 29 May 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="lMZ9s2uu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014C180A7D;
	Wed, 29 May 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977467; cv=fail; b=kUWJCtP9sox8yk6N5+Epp6lMiq9pQhKzK/kE9krwYyzyggYhBq/vKlCRVaKgUvuXYFVFqUu1hhRns1DQuMNcX4qT4Hcd2TAop0Oc/r4zUd6dgJAo5CWhEoluYF9ZIPZJ3UHxreygPFPTbGuEd7wZoSPkfE11d1iswckIWTzAZc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977467; c=relaxed/simple;
	bh=q7kaxIURB8xAnS2S/IQovHbVsPKDgH7D4X2/1xN9QJc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WkV7lXhx0hF87z2EFnMd4twBbXnL9prpmuEF/kR3iKcwEqLoZYpPQCWH0bAU7NRi3zaj3x3LLkoZLqXnYJGFbKRm/gqiLQXBmRsM/zV0GMRIa3cPpgNsPfBPd8lf4qBS08v/N3tBmjMJJtZJiyPnpBA1rcz3weVdL0SM7CbfkJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=lMZ9s2uu; arc=fail smtp.client-ip=40.107.7.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE0Z8OFYley903hIe6Y8f/+1Ze2k6tO+1hFepz/JFzT2fvR3ivgrKlLW0eceatJ73g98Ciu2c4ex8xnaj6e/9oJMuZ9b7WoZeh2dcWtadttq5k8oR+tA7t94k47LZcsAIPBdIT1cbWoCzKgetXDBZTI+tZqD1urdP1MONLmoX4uT8ADWTesfmOoWW4BHgWGi7hyYCXUjQrZ4lutVIitO5HhudoINToem9Djn5UTU+g53bRFDVxBHysRigH3CGWeK6egAvOHUIOK0jOwzl8++KDkWZWuZ5jhRSXQs7FKYg1qoTbtzddkyMwnTnHT7RdF8ahOG8xJnlvPiIjhWtr56rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfsSJgRbvl1c86QAKbFelyi3eLg3eqC4arVck2wwsEU=;
 b=UZZ84Sx6I7ABlSa5vLahTjDjeAMAnMRuxwDfsdUVcduSvUDBH/OvNrXa8V2WmBuxqOgERvhf6V/oJMTi09UakjEFlbnomp/282V9bo/EnheOonOJiiis4v3ZcWDK5hGQ7PblM5LD3cvbwoa+exYzDRcJpSsdnpXNrk3jfXrEynjYQkfDNTdcwyq1gAZXtbeTwJh9DN871hBmeJtf11K+yBdHCLzrIXSt3BbW0dQx8e5zUWQ16eWVZwGC9yjtfwS6rHXhe+2FNUyp3FzNd4H9ZY5naKaWMwu939jLiu/WU5fOD2WBFePTAXUFcjsPBOi0HtFCAlrr/LUeeF928iVpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfsSJgRbvl1c86QAKbFelyi3eLg3eqC4arVck2wwsEU=;
 b=lMZ9s2uu5K2DHqmIVgLzKUN6lyL+MLu28Hb3w7PB9ig3F72ggny58AtM0xJs8wk0K0gyhjWQOyzqbogaAkPxBM1UBFUQt+cmMPDLpytUrkRdnxG1eNCIcvNVzJozi+md7zPXs6akDHqudE48+SxdKevQEBFjLBd7NnvyBEh8NHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:10:54 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 10:10:54 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Wed, 29 May 2024 12:10:34 +0200
Subject: [PATCH 5/6] arm64: dts: rockchip: add pwm-beeper to
 rk3588-tiger-haikou
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-buzzer_support-v1-5-fd3eb0a24442@cherry.de>
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
X-MS-Office365-Filtering-Correlation-Id: 669a2153-8fd4-4e70-356e-08dc7fc79e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enY3dmpLaVVWWXE5S0VKUnNaeUovQ3BxWnhQdG5sdkMxYUlRcldYZkhnK2R0?=
 =?utf-8?B?QS9FM2RxdTJURHJZckdDeWNFZGVhSnY1emxOTlhpS0xOaXpZSzM2SGJJVzlq?=
 =?utf-8?B?OWdaMnQ5cFhSRGFSSEdaeEFrdWVOaXJDZUJadjNYT1oweEpXdkYwcXZwRzg4?=
 =?utf-8?B?eDZmOHY1aTNYV1BnelJTdyszTjFCOUFZMTdJVEZBZHpjM3dKUHFyWkphcVVJ?=
 =?utf-8?B?V0FodjArUmk3aDF2RlZUNDJtWGNBSndSS0IwVWQ4NUZ4bHBrWWd2eTk1VUxZ?=
 =?utf-8?B?c0JFQmFsY1puUGZUK0l5UlAwQmxiTzVzUlprUHI3TkZvbVU1ZWR3aGhhZm00?=
 =?utf-8?B?Skd6OU85R2ZvSlkyVHJheTFNUXFraVdyWm5uTlNNcGRGdGUwQlVieWtsUXJW?=
 =?utf-8?B?WHFiWHBQVFVxSVJjTkZ1anNma3VPTWpZQUtLVUN1SndDV3MvdHZkYUNBeDVF?=
 =?utf-8?B?MjRDekRhNFg1eWVUdHFBVHUraTQrSWFTdFBsNlByZy9KSUU5QkEzS0tKUVZG?=
 =?utf-8?B?d0ViQjVvV3VLTjhnM3MwbkhGWDdTdlJNWCtPcTY0RWhjY1NzbmNtODhJN25r?=
 =?utf-8?B?c21hdEtWTjdMa2lkMmlhQmZYM3pGS3JGbkxxaVB1azFTS1haTEhMMUtrZVoy?=
 =?utf-8?B?d01yUytqelA0TXBSc0ZiZi93UUZyNXlCRXJCbGx1UFpNZzdUVzRLSHo1djBW?=
 =?utf-8?B?TmxOT3lwMzVpSFVoeHdYWVBFNnBJcmF2aEN5L08xdUJpSUlnaktuSlBxL1Zx?=
 =?utf-8?B?YTA1OFQzblVVMXhsd0l1cTNWR1ZLejR6RlR0WFppZ1MvNHUzV25Nenk2SlVp?=
 =?utf-8?B?R0FOdEcxbDk3YVoyK3BKVWpXNkRONDg4V0EySVYwNUhQNDZXUkJRY01BK0Vz?=
 =?utf-8?B?dElDME0vRnVacVQ2MU1GekprWG8rTDdEend3OGs2V1JKS1QycFE5QmxUZEVE?=
 =?utf-8?B?bmZOMnQrM1NpQTRiOFpFU1lQY3dqSGUyakNkZ0sxMWRwVVMzVVRUdzg1VFJl?=
 =?utf-8?B?NCt5TFNha1RMcURaRTlhUzdXR01CRE8rOXN1QWpTeVlVMmVnN2xla3pJazNx?=
 =?utf-8?B?RXE5MGdpeXhRSkkrZWVvaHUxVTFSWi9MV3ByclhzbzNnckZzeSt0dFVWMUtq?=
 =?utf-8?B?QUJBTG9oTit3QUpWK0liNUN2TGlMNzdTR1hodEliaFVESkM2NzkyWmVLMEpQ?=
 =?utf-8?B?ZGhCMEVxMzVuSTdnY0pNZ3E3WEVrZUJnaEU5YSszMkk5Tm12b2RzSkpnbFdR?=
 =?utf-8?B?STYvRk4zMjZTR215NjlueDUycUpGR1FlVmVHdU9icVJBL1lVcVVWWEpKdU1W?=
 =?utf-8?B?empRNW01a1Zoby9EWGVRTjhGaVlFdHZLMnhQVE5VMUNvR0V1K3hZT2pqbHZP?=
 =?utf-8?B?SWc5S2FONDVoL0prN2RoYVJUdStKWmlmbjBycWY3VTN4UHhlNkJ1ZWxDc1hx?=
 =?utf-8?B?bTRZcE1qU3JtS0krRk5CZ2JkRXdYeWxueEpKVFVyZWpSZVpSV3ZvcW84REM0?=
 =?utf-8?B?MExteFluT3FveHR1RlBoZml1bGN3TlZJUHJ1RVlpelpzcnJxMUxzV1RxZzVM?=
 =?utf-8?B?WHdxN1JQRmdUVWZiTk1DdFBMaEw4R1ZLQldrQXRjMXlTeHJBdndxSC9ENEFy?=
 =?utf-8?B?Um41eDdDSzFtVWVkbldsNmN5Yk9NS3hlNG5QNVhzUkw1QUhJUGpNK21XSmtz?=
 =?utf-8?B?OEVOejJySW83NFJwVi9jSmxnVUNhMmdwMzdUbC9udHUvaHNmODhIL1M3ZFJN?=
 =?utf-8?B?WHprL3Z1NXBIV0JtTlgvZ2UwSXhhbGpMTjhoS3U0Yi9ZSzcvVzQxa3d4ZnRC?=
 =?utf-8?B?VVZZTm5vcm8xTVlyeUJOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajlwcG1haVpXVVhkK0lIc0NQS2paT0lNVGNJVFhnWWEraVB6UlZVYXNJUFgz?=
 =?utf-8?B?T21ZSTE3KzlqUG5kcUhBQ0lXODRkOHRiem03eEVKQ201R29LNDdLblFVSHpO?=
 =?utf-8?B?blhoR3UvNzl3ZTd0ZmZvOWhCSVlSZjI3SHp2UnpGb0JOUHdQdEpBRDRPZ2dT?=
 =?utf-8?B?NStIUkZQWEs1ZXFmUnAxSS9OSmdNWTBRdmZpTzlDNGZzaXgrcUwvOEFRNUdP?=
 =?utf-8?B?TkxlbjBIQ0R0eVJkdi9sU1VkTEp2ZXhDdS9Lb1ZDRy9vTEpWOWZQZXBOS3Rp?=
 =?utf-8?B?VlYvWUNoenMrRHU0YUxMQmFlZ2E1UjVVb3R3dnBmY3A2R2p2emNndm5WVUhh?=
 =?utf-8?B?NEZRODFXSjNSS2RMSGxOOXJzY1ByVEViRkRMS3c2MDNnOS92bHNGbEMzWDhV?=
 =?utf-8?B?cHNQeGR6dytJaFlra2tzSnJhRjJzOXRGQ1RIVGtYWWxFdElIVndHR1VIU2hX?=
 =?utf-8?B?T0Y4VUJDc3ZiNGNBN1lXVUx5MGhsMHk3M3lYL3YvR2xxQkpaNUhBMkFtVzc5?=
 =?utf-8?B?YXExTG5pTkNWWDJHN2hVY1VwaVVuYUo1WmJQZnNqOHZ2U1JjZW9rWURTcFYw?=
 =?utf-8?B?Umg4blYwN0ZHamhUNE5udHFROGh2NXBoc0dIeHVOd3RRMWhsNHBhTVRMUWs2?=
 =?utf-8?B?VzI5N1B2bThudVN4M1cwS2lsaURaUEdYb3A1QkRBMUxOcXBBbzlhMHFiMkti?=
 =?utf-8?B?dkN2UkRkRkNQa3hMOWtCK1FEZjcyRTgxUDlJa0IwVlBzVzhOemFKck94a2ZQ?=
 =?utf-8?B?UHZzSlBiSnVTQTM5aDlRM21ObERSTXl4NG8wRGlBZTgwUUZrZjMyMDhFNzRq?=
 =?utf-8?B?NkF5ODUwS0dvZ1RsZmJheGU2UENCODVHelp2TWg0NlM2cDVyaWtlK3lmbnJ2?=
 =?utf-8?B?aDNQUDY1MXNvbVozT3BkSURPY2ozNFVuWC9xY3kyY1NXQlNGR1A3djJmUEFQ?=
 =?utf-8?B?bWJGV0JiSkxrUjRPTEs3Q29wWVdPb25BKzFpVFFKY3VocDd4T0dGV2NxSHRQ?=
 =?utf-8?B?Ry9xNzNSNUE2SnRFSlhDYWhadVJSYUxCZjRVd3owS2dZakJvTUxnRnlIamly?=
 =?utf-8?B?cUMrdGRZVUxMb3AvQU43akswQTVFSGpkZy9qaWRBSjlTU1RheFhha29KOGFz?=
 =?utf-8?B?YVRiaXhaZEg1a3AwTVhGV2VCQkhwMFN4SXZZeEVOODNKaG11WktsWDF0ZW9i?=
 =?utf-8?B?UVV0OG5hNGFmUk55OS9QZjJPdTN6dSs1WllxcmRCd2RjaVlUNzBhY0w4aDVX?=
 =?utf-8?B?WU5yVmI1bkMrKy84cUlJM2d0OFFKY1pHSlZSc2ZnV3E3RkRXS2NKenlxT1Vy?=
 =?utf-8?B?VGp3anp0Ulc2RkFtZG9YQSsxU3dzVStsT0pzb0U4OVNnVGtJelRlc1YzTDZV?=
 =?utf-8?B?dGFueVdER2F2QkRESDRNa0tObHBrVU53bFFYUkhaWVYyUTJTNi9EN1NpYTNv?=
 =?utf-8?B?SzViV1dHcklHUkRjamkvYVliQnlnUzZhZmhOUGlhNCtqREgremxIRXBheWlm?=
 =?utf-8?B?MVJ6NW5VSTVERC84VldFVGg1VHpYbHVnNTBxd0wrbi9ESkZjUUwvYWNnV2Qx?=
 =?utf-8?B?WjdKalZ5aWhPT3NMQ0xUU2VPN0FRMTVzL3h5enVnL0haL3JEUU9QQ2tIT1RW?=
 =?utf-8?B?Q0tRbGx6UnpWUzhwbURzdG4rT0RaelhyKzN5aUc5amVHQ0ZkSE5FaTN2S2J4?=
 =?utf-8?B?NEovTGtDTjNKWTdOL0xUcm5XditBdEZrVThxbFZqMHJ1NnlLN0JyeVoxYTdo?=
 =?utf-8?B?RFFYZVFzemdqTnRwNU5uUHhuS0ViazFIRzZqdVNjQStzUmFERjQ3Z2tseDRI?=
 =?utf-8?B?dlhkc3ZzdE84K0JzU015bFpLRzRnQ1hYZW5iZ2lIanJrUnRtQzRNYUtNYUUz?=
 =?utf-8?B?b3BEdjJKbURzeG1vSUM2VXhjTFpRYXVMZVpZeEZ1WUt6QzZLLzNxMTJPSUtk?=
 =?utf-8?B?QVFSSDUyallXUW5hZDAvV0cvTEMrVmk3eEdmZC8yUmpielpIWWxCL3FlU2dH?=
 =?utf-8?B?WndUbjFXUUF5YmhKVGFNVWRHelJlR0krd3BnM3V1TTUxY2o4N2RHMm1LdWdB?=
 =?utf-8?B?NVBvejd2aVhiUTRpVzlrNHhoM2x3MlZqM05CUFlxV3ROeWRkUWViNXlKNjMr?=
 =?utf-8?B?RUI4UElVRFJSNzh5VCtUTVNoU1MxekN5T3RtSWIreGRkZ3prTnFldnkwUU9P?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 669a2153-8fd4-4e70-356e-08dc7fc79e71
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:51.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzQgMpU+A4/GS1Iw6AUdFUqzMr8HFh9bRb7qplZ5svdiOC3IhwLj6BoswqoBAGH0ivPqspv3QitYPcUp6OOreWWFsymdbP0EcE6WrXC5ico=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Add PWM-beeper that uses Mule PWM-over-I2C controller on i2c-mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts |  6 ++++++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi       | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index d672198c6b64..cd5f07ef70c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -16,6 +16,12 @@ aliases {
 		mmc1 = &sdmmc;
 	};
 
+
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&mule_pwm 0 250000>;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 5ed7d51717bb..7b95bede4621 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		i2c10 = &i2c10;
+		i2c11 = &i2c11;
 		mmc0 = &sdhci;
 		rtc0 = &rtc_twi;
 	};
@@ -228,6 +229,18 @@ fan: fan@18 {
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
 
 	rtc_twi: rtc@6f {

-- 
2.34.1


