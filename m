Return-Path: <linux-pwm+bounces-7084-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154CB29C68
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 10:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F5816360C
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4702882A2;
	Mon, 18 Aug 2025 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H3gVDOEe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012055.outbound.protection.outlook.com [52.101.126.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AD25D549;
	Mon, 18 Aug 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506206; cv=fail; b=iLV0OL0pJ4bkF5ZaIWMKpQK3PU5RJ+5TVOt1FTejAgIQ+NKcZ9EnjrrHprfmjm0/OzavwCgOy92mxlEFGKVTqOYaUHGq/wD8f6h26r4GbctCkPJJTSV4ONj16nSXproTPZPuHshZZ83/FqW7JaTenF3yZVBXvT19K8tw1fBTI1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506206; c=relaxed/simple;
	bh=w4v93K2iMie2sPx3G14PvxIqIIpOUYMrtf0ML0FbMrk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u211ykvgNc3QxXLogpfiLXfZfAU+a6rmPjgX1Rd528kFrMjLnVGQH1wvkDCYap8mWs1rgsiAK3nJpC/DIM6/nord2cMutEQ/wWPzWTzdY90jAl9cAW086NzUu3dprDDUXI8ueml+Qvs3b31oeW/EhNapYUX1dRN3Ms1p0Ut3ooQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H3gVDOEe; arc=fail smtp.client-ip=52.101.126.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4PYusffo42Gri4z7eIkKOX8/IgY46Kp3PWJfxP1x9M37XlyYKBYKxjCM5K4dYZFh3BiEKV/Ktr40T8ksxlE8OBfmamGMSia8vrxOitQNhgQTj0XPkNYxUJ6JxpoycS8mRkJWLoC0H6/TVdZ/8cO6aWtagha+h93H2PGS+TjMZgYZxKoRAMKCiFrO8FU2nOmcT8oidp38nVMaiXIBM4P7gcrQ6ivyYU4M7l+uAjeMOWnNn7lcjn1UXzfIajflOMKWl6aVvGEGVOy74sGefMokrgHo042/r0od7tk2cuwuotgdfQ1OQtPG4LypC70ILJSVaGUd78LEttL0Bk1voq4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA15McHruuVKkTKiSJM/jKkiCdZDeACOgrCUBXKt/yQ=;
 b=KwHpRmmpi4AhvLkVOW2P2sHwdHz+kVcLKIRJZwue8eK3j5ogGjQkobCIjhc4JcurjaqKvGKiG/JXERjCBXmASJa7ZnjWLg1d8XaKN3qipAl74gYu9Jm0LCoaJDyUEBYMaKwk207tX+CWbmA4sQEv1HqEwFv6flKEuU20vYyIk82wHwSl2Pk+qGtQZeDpARQHoQUTFR7ODMY30I/JjArb6gTMclHVQMa6g9uNXCb6VCc5cDG2/tBDLKIsy+jJlegsfeNnGogBbUW5sBY9yc0lXFCxX1VBid/GPoFYyQczz/lbG3GiK/lx2lYKw+C8aMqwzm88UkuT7oT5ZFOXu4MPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA15McHruuVKkTKiSJM/jKkiCdZDeACOgrCUBXKt/yQ=;
 b=H3gVDOEeDfCdHT+u4LCbxLuylEY/UOvjGSPJGoHJLgJSQQN2Wo1VndGSYBYXrs/wZYcXK1SfroA+h7gFEuyap7EPE3cVJN50++R54jOh7SR+gQoBx//pkLZyt1UupgC0cfKID6niSu4uc5TsgDdlDCTketZOD1V5Li/Layb3X6vlTgIpbMFQPeNvnmJiBmaf9TY6SzF0UnZYU+7zni2ciqtIsF2ADvgemSQ/lKRUiNCUR1HxYk8SDt380eElDIjxOx0TufoYdu2GUuh71zWe8ioAxPZ1Twxj/xq4hdK9h3wDD0YM8H7U8EjCgKcC+bJiXrMZLxftLiA0J4VdQGYQDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEYPR06MB8091.apcprd06.prod.outlook.com (2603:1096:101:2d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 18 Aug
 2025 08:36:40 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:36:40 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ukleinek@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] pwm: use str_plural() to simplify the code
Date: Mon, 18 Aug 2025 16:36:29 +0800
Message-Id: <20250818083629.503250-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEYPR06MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 01811757-c5b8-450c-a2a4-08ddde325a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZGUNUQZ6PIV/hthjFvfmn8WRz/7rzlm3CwQg7NZHLfVAk/H5pKU67Rrwtc9?=
 =?us-ascii?Q?pnXhi1z2e4egtN5hMxGTvRNzSh8tG9ruaCsrCDbe5STLV9V3pG/Yaksk3Tik?=
 =?us-ascii?Q?dZ3CAEERAG7nqSOuTIuKqi/JasYEgBOZnFsNgb2L9T0zer2/6KmnxyEHsDnQ?=
 =?us-ascii?Q?VqrxRKyfOAPeeKOacZ94DDKbBAeNakOin2M74HIQ25x6NSW0s3oWdA4pNuum?=
 =?us-ascii?Q?JevsN1P2vTH8qs5elW3I/OH3kBpjBG/t8InXckcGzh03bwW0x+EE4Rjn32qD?=
 =?us-ascii?Q?V+8AbDD8SUnpZoKaZ1lFKnslYJ+9Q3ItZWX9MXhRhhdMxJoF2nGsqNNxAJFf?=
 =?us-ascii?Q?2ZlHEp1YIpcW64KMu0PsKQVoNaiV63c0SkETda4rvtmj4+Onc3heTHUknK9M?=
 =?us-ascii?Q?IS/oHI9yrGgiRsfT5AjkV2HOdF1uhl1lddbqV1F0tzzy3UJjPQFIfYg5w0QI?=
 =?us-ascii?Q?FNBco5493ycD8QaGvuW2YPi6UYaFqFPMYfpDa3GMmhMHTJAzTOzizAKXVAF7?=
 =?us-ascii?Q?RqGqTreQGZfbqFrW2ueltqxN07scZprDZLScL4/glHX04treL587geknDUwx?=
 =?us-ascii?Q?NoOe9ohcQH94ekElMWePBEv9QC86S3YBQhjMA/mpLCC7XAx4JIVYmJwmfTe7?=
 =?us-ascii?Q?H3JR0o1qhrtuItBGEcH6Y0atgdI44cSnOiD7VY6FHUe4XErz0Wnl6RlbDu0A?=
 =?us-ascii?Q?UbKpk/dJb8j1BFEs8ZF/Ib4AREBnP7CCVHs9pw8uxhbaYYiFpEp1eLB97il7?=
 =?us-ascii?Q?nB3Kp7n9cCUQRg4RYa6Lt08MRZioVIKrqcOHWlEDTrhx5/BWVhwxyGU+8Ltb?=
 =?us-ascii?Q?HmegVW7H8TqBN5s3nh3ORhJmde5nAtSeEsqQBfoQNIm5I9JoYUlT/eoHqBiU?=
 =?us-ascii?Q?ESzSb4+6h9uKoyDev47DJpmjvAsl9LbjwtKGfSMfPH1iRLIvm5Ae8J4Eyuiw?=
 =?us-ascii?Q?bx5PZzqDKr92FDT0pSD6umoNz88h/ro4VorAEFaIC+iwKor3BQL5n1PJK69A?=
 =?us-ascii?Q?GUjI/MQBEYG3LnnZAldT/1T6Z4mNrvIinNQmgPJKdbVsByVTvD72D6AqRl3z?=
 =?us-ascii?Q?dyca/Uz+EzPwrYhcszE/3QHTiMM/n5sIdlbMXA1zq8ogw/pIO1Js7P8mueSb?=
 =?us-ascii?Q?gO359mPr2pO9iPm5M7Z43ZnNaXeRnV34YrmLXd5+YDdSYlhJpsX/pTGP2hSG?=
 =?us-ascii?Q?OWdLdK2G3gRr6ErSqbpkc0nzA7qhlIWyudjPwsvtCfGE1j/UMU/lzLMLYH5a?=
 =?us-ascii?Q?qX1fBsJeJca99Q6wZ9D7NY1NTMwCCC/tpt8Yq4UrVxg6LeK8fOyQErrhddVh?=
 =?us-ascii?Q?X9QQAunSiMFdvUor2fP5e5fgD/aBguighp4VmiWBwfSzQn7HJz6OZy3OLhrz?=
 =?us-ascii?Q?PsxEjCYS+w/HHd05GskgWmWTfyDuu7z+wui0YiqBGdMMosEthZ8MO4C24pLA?=
 =?us-ascii?Q?o04F2I33fiZK4kgGrCQ6dSxu7CZaNgSVmQreda+LnYzjS5hsD0fzuT3sRR8O?=
 =?us-ascii?Q?CLvRO5jJ3M256G0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?My54lDLe37b/EcmPW7FkUGBE+iHo9MIh0CiPXHRPzXzRG9nyIt+OiKJUM551?=
 =?us-ascii?Q?XiLs7k/cei29PIAqnv+Cbd4ccfJRPXuYAY/A5+L//vSX/oiJjDDTUFwzYHUH?=
 =?us-ascii?Q?g2NRZby7dXDwVkVNptIIcmpTVa5vo3WduCwIQ876Rg8Bc0IS/zt3fObZK3YI?=
 =?us-ascii?Q?rmnUyAftwP8R/WVMyhjCL0jzjIZP8ndulkP546lomeyZngl9UspzLGqRvU6J?=
 =?us-ascii?Q?CMb/QEK6+wdbAIYql3RQxun67cG//spIJoQ5zU+yUVc76SOzbFr4v7pBjwdw?=
 =?us-ascii?Q?71MHduQRHDigV2luLInexJgt2ZQiRJinAT358J4e+GhS1/NBKwNa5dNcOzF8?=
 =?us-ascii?Q?CYtOWzeikIy6y3LPGOiW+pbqb2rgf2HUgSiOiL/F4f6fTpvzsDq0E8n/sF8K?=
 =?us-ascii?Q?MoI7YKL/HoRFXLsVYjY7ilsnh4SoFugcUnYv28+4OKALpPlnKwIfglCmEjZk?=
 =?us-ascii?Q?7LduFAZIPbkRuCOTsgjChQoJWXt64nwwozkUmc5G6p7IPUHU217rVW3ZW2Uq?=
 =?us-ascii?Q?VbsYcxw3zWOJDQhzPI06S3eWmURm8AGxRPMjAyYvkZO0WOZ3NcgvMXWT4B4H?=
 =?us-ascii?Q?uz/ptnzJf04xpxbfhLznLNWdZ6oL+DWmyKbRb9HagCfNbzRpLi7Ipa/EeMYp?=
 =?us-ascii?Q?XMwjI2t0/M5bx7MANrnIwc/JDhLHfL41SPeADr5xrPGt/jvEATOHuIzot+U3?=
 =?us-ascii?Q?sICbb1ncPTZEDcqs4HCqMdlzuBiP0IswvPGQLNHp7SJtvJJ5+S+aS4O+P4HK?=
 =?us-ascii?Q?ZzkB2E0NLRCCUmrcw8I5xHTAMuzZ0COQ9gcJSlHS+SFUbX6Bt5E7RfAz14tm?=
 =?us-ascii?Q?4ml0tNQvAb52fYzxBIcW+O2gfFC9IjCzEtbtQOtNIjueQg5pUioGTnY1AJY9?=
 =?us-ascii?Q?CqdV6iETk6VhfWVhsY956cFESTN4JYZK3ujdL2M2xRGFVCA99SFbJ8NKXKNh?=
 =?us-ascii?Q?Hu7U0ahmGyQt0KV65ilzdK8ESaXsWlR7ONsOsvxAHM2aoFy8PYE4HDdkTeLx?=
 =?us-ascii?Q?SSrzF1uI9xxxkEBFFpO0K1faGuUx0oc4N1U5IVYKbkqcZKMhbneoQH+gkBNA?=
 =?us-ascii?Q?GUEPuKmlBLDbR63NDtna0d//t3vf4UIEN1FZY8foHYmVedlz60dg9kq36jVV?=
 =?us-ascii?Q?BWrfxccpLsbHtllXk5ZE10b4+Ev+BeaqJMZYLe8dXwa+QqTP2VQGGuqmmNed?=
 =?us-ascii?Q?aJS1Rw9gAeP8IydbZaZx6+T8fUGkkNH1bNV8HjoWh6zaUfn37X0kL3YzpuOg?=
 =?us-ascii?Q?OZ8gmuXHrz4QH+XpC/ppdHZkApHe09RHRf7J8WCB45khUTQZ8+BorY2Mddrl?=
 =?us-ascii?Q?7bByUhbfZO+8SBy6mvNOKZFijpQZuxDS5gtwZ69XWrDL1UR/RyTpl2gAu4Ma?=
 =?us-ascii?Q?bITbu4DZMlRoQf7t2WRPhZXEiM3aXPG2mV1fyFXQjHpwYy6XREInt13RIv1b?=
 =?us-ascii?Q?yj3eRLl5dRBWlaWj4vDZQHKWqX52xSPHQZV8vZI8PwIsDXYUXlhlxgeVA4oR?=
 =?us-ascii?Q?dIs9/qPmpieTIkkrxyCKE4UQukDUp2FHlEjC4DYRuukysWHbaxywQycROiV/?=
 =?us-ascii?Q?gmrmyeLGe5Rc6li9rnvILN1U7dBhyapvSb+mT5Dx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01811757-c5b8-450c-a2a4-08ddde325a38
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:36:40.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEFp1vykxdlqWUIS0KATotsqtZWTQSFEQ4faR67AZjrvH1nSuwUoE5ROPgNlc04D9HWQEjKUW1ld48VHpisZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8091

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0d66376a83ec..732d22dee035 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2620,7 +2620,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus",
 		   dev_name(pwmchip_parent(chip)), chip->npwm,
-		   (chip->npwm != 1) ? "s" : "");
+		   str_plural(chip->npwm));
 
 	pwm_dbg_show(chip, s);
 
-- 
2.34.1


