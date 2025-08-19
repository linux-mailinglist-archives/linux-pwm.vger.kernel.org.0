Return-Path: <linux-pwm+bounces-7105-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA7B2C978
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23777B8C37
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E5248896;
	Tue, 19 Aug 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="a2a0uFPW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011031.outbound.protection.outlook.com [52.101.125.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC992580E1;
	Tue, 19 Aug 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620608; cv=fail; b=jdONZBnR0389mCqKy9HiM0vYa4lcxslWNgu4gQGieuVV2hNWbiWvM1EmnjCaGaDOONTMMCdhpYFrQk4YByh8FzLRIROXZFDkH7YsL7Lsi77kQcxdsoG1YWOIwTltQf9GM0+glJqma4PF3pxIAKPfwf28azZ9bQLJKcd9tbaT/ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620608; c=relaxed/simple;
	bh=mS/MeXIQGC0nxsGWfb7yxRIfFGkP/VS9Kb5Fp87uGFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ef6MKn/uynUDs7fYSyZckifb75vrZ96a9uCsnf5TvmMDRqCYv2fC+o/LlZL5/cwKM19XwwtUh92J8M7X3zj8a1w9+YEfz2vNvky1/qOisDKWp88ysy47kpFnSLWpTYjRXizl6MA+6mv/LlhX6dK0BwAhy+eg1E/kMyjlVL17Zk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=a2a0uFPW; arc=fail smtp.client-ip=52.101.125.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw08jSo/s2bMhWjTZFNXBwHQ4nd82dPgBDu5awzs6DpZmqBpjWR9VFv6sQ5rAG+eIyusq/w9W8xyP0sTV8xmXJRhunyki97SXULVj7+KnJby42XR7w381ySHUTFPO8ofmZ7biOXQLTEqHSUt0uxCprQLj265o+nQavocayHW4uQkLd1/7MrdLwSf3qPr74Xu7TgiVXL3FJr45ilytofT6tjC91ZE1L6vMikhpd+VN87l9DBHPaxoCE6hPtBXM41AUqN2cRripO9j/MpLfI8yFA1kCx2J2PSvHvxyHmm4fGUplBhrjriQ4wd2Oh6QA+vWdli0GAXxxE7NVo3VYo06HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFoDOU+92DHiqnwr++zNZ5eI8UCvDybdJZ96zah4gDY=;
 b=YHhI1PxQQ0KH8/TWOOMdJuGSan2jDL4e+5E4twP2ZsFXEHoRsFv3OOqQi77pI6g3bvNr2URR6iqac1B9NuWeoTbwKNfl5m3PeVbDBZ5sl/WX5LEFG3hoYp6HjEsSBis3fJYPw+33B2baswasrVUGnqoIa/OChtzA86TxDacPC3GMkYMv+0Io+BqWy311mx9VOLPPU+YzKo3g2w8XQAE/g6x7PqNFNnhChI/PeSno9vKNzelTI4BO11kHkW4/URK9+IZfYA1WxsEeAB/tIYEgs1YxJORdBzqyqpm82McKImlY1FLily9f5UtRFWq5jYKGVt5aid+hWC1OIe649jYHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFoDOU+92DHiqnwr++zNZ5eI8UCvDybdJZ96zah4gDY=;
 b=a2a0uFPWjem4obuoDXccBPpR3auDECrtGhcl2tklsxEfESBCftk4iNtpn+X5FY2oqyC4BoF09DyLyFGBT4zdPl2eeAdvfd0TYe+CvHn6H5VqCzSFcEf0agBw0kCeKeCfrFxDpK+aU2/zGsM0OVBBMlqkFyUEkCJFUHRjtbl2kBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 16:23:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:23:24 +0000
Date: Tue, 19 Aug 2025 18:23:14 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5/7] pwm: rzg2l-gpt: Add RZ/G3E support
Message-ID: <aKSk8ozFw8wHbSIH@tom-desktop>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-6-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184115.192930-6-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 59854a95-babb-48b2-5d2d-08dddf3cb842
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cp0Po2N5UT7tQ/x0u2pdEwv7FwF6kDNlXQ4ZvtPf5A3gUebWBqn0cqyHvnnD?=
 =?us-ascii?Q?NOtZwNmmHSrCw6Qam9WVDETadcQTOo9BfK898zBjuF8tvMTMm7+psNgCKHgp?=
 =?us-ascii?Q?3M5mWo9A6nUOHRloqhgm5W32MEfvkc8lLxpU+/nQkTvyASEtIzJCBPdWEnNu?=
 =?us-ascii?Q?9aFHOy1uX2UHtQV3XaIpDPI0YBmaVfTzUNKkrrnReGQlA8Kwaehvohgmdsb/?=
 =?us-ascii?Q?ukyLzJ9NvrtAQiO62MC5JsSyXxX0B66/X7FVeHRYCXYRPSgTX62YuoBRKhST?=
 =?us-ascii?Q?Dxv62i//OHaGISsG6xBOoJbN9yxwntyo1LFrqdbbgShKXJRvCvWk7AVcmByF?=
 =?us-ascii?Q?ISZFdwQtWvNhgE6iJ0aU1Nf7t+LpiSnHOip5vk02jx1gGduv4z4LNIWgQox0?=
 =?us-ascii?Q?JdTW9p00RZXPtVvuVk6pPKjHC2b8MD5LFvmN5M4m5cQdbcMXF6rFcw1O6YS4?=
 =?us-ascii?Q?B0/wyXthZWmItPp8f+1NvZs+6RZnJAGtRGmTQprvc89oGLZCuD9fF7/EG3Vr?=
 =?us-ascii?Q?j3nxhZJqy+0CmSDzWTINqDfVH4auwSgqMVNPFBNmEwIhTzg3t3dAfhXvM59F?=
 =?us-ascii?Q?It3bnn6MNfQqdr0Rb7kpmkIb2xCc2WsXteipfUm3K/MJUAJlNuFEHprHzJXn?=
 =?us-ascii?Q?0JmcdqD+oSgxepcksUxCOt41qgbWWYFE6DSW3mJS/JVdiCWJEI1TTfGhXm2e?=
 =?us-ascii?Q?gHz/To6F1xkqog1NP3MzkdJrk49T9lAJkT4k8UPTjJ8madANR1gR3kuvTXeP?=
 =?us-ascii?Q?8415e1rNIQd6viAFTE0jPOrZs9fmdvQScxZQqUDz/ZuEmQ5cbWQ7aJ7Ap1lK?=
 =?us-ascii?Q?ctdT/VkPRjWw4AY1dA2G/8ttxnRIYcyLxFuuOEYQddqiNI1rmejrcYQZ35PI?=
 =?us-ascii?Q?Hpx1u2EBI2DnH3RvobTMbKPiTZoNX5i4WSBjeTwH+vGiPn2YJkxw8SWKdVFn?=
 =?us-ascii?Q?lPhJMoBq3uuo0eoo46Yovm1dXsOBNHOfkvrrG7A+ik3Lf2wKXIDvYNQugiXs?=
 =?us-ascii?Q?O/2PYOeUq+XPybJYQv8HEuQU2Ytrlf4FYGVChxtiYjmXspo4EZWfwWY5zMrp?=
 =?us-ascii?Q?g5kcbJKplxYONQMv779nj8Fys/O0auVEoQJk9bTQ4fauydyHyhVqXcmKZJGF?=
 =?us-ascii?Q?p0N0wfOmVckWLz8u5eT8jHvmol1qE7RcK2Q7DWxtBH/mkVjUwP6hi/JF29L9?=
 =?us-ascii?Q?QcPWLzOlsjaMQcNPbLy5xVJMfMl8v/mhsz35xaoc9KexgIPNMfhIWjjtIwCD?=
 =?us-ascii?Q?rYZqMBCVXnfHJPHeQSomHSymGzaWy6YcPT0cFtqGhS6dXjebkkKjB8nt1RrI?=
 =?us-ascii?Q?YrMVbmyr7IDkK0ByDiJK9YV1wkLcu9jLCSeQUirYQ4pVcBK7oKUjhbN6bfar?=
 =?us-ascii?Q?Blfnuj7RHbDgorAQ0NnINdHuTFfvbqNIc4H1jX6gcXM4uD4JAxi/rgG+BHzf?=
 =?us-ascii?Q?bTpsS8DUc772XVWXjfcvjtQxTYc5fiU515rKcBez0xnPciHo31aLzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sl55L50Y/Gj/vKUlX4z/nOft4zp3W9O7++BQqKyQKJgRd7P34F6xpFjpJ4Ex?=
 =?us-ascii?Q?0oXeTkPGlg8dk1Eo+rJVAMDsWqFkHp6WdefAaNjEC3VfCJOGWhJjKnFSQ2+J?=
 =?us-ascii?Q?rgVA7p9p+x8QjLOvN9Sgt+3HVysVyeiVuWBpMauOqcnJ+bSPQ1yU+11NmuC8?=
 =?us-ascii?Q?eWwpSUmdML+0sJG75zFfW+pLeC85fRCx9CApTLTJ7BGPE33vHcirlRtymEuz?=
 =?us-ascii?Q?88NfGJIbElC5aWpmk1a2wo1KDVxnqnBAZzy08gdn9t6clw/6vSrsPdy/y/9/?=
 =?us-ascii?Q?u+Yp1EhW24hhXQTgGL2XXshDRrB53rxyJDrh2hO+32l1Yh7+36WL4OKZXobq?=
 =?us-ascii?Q?8WqUF8Vu7cku+YTQNvompm2KN543GUHM0GbUqhPR3+QUEQ08xYgo4xHQbB7F?=
 =?us-ascii?Q?+jhjLWRrCl7bO8un/JKKGWRcgybacFsRWlRGicAm/00jb5xSf+Z2pvlrBBDp?=
 =?us-ascii?Q?7dGEKjvRW3+u3wX3Zri5T8GaJyga3pWhmyHn6eFaEPSoB+u+CsJnebewt9CJ?=
 =?us-ascii?Q?NFoZNis/rwI2N2h5k+J2QL/a5WJ7NTwd50UStFWa/feKkyjYNoRWWrZxQD5N?=
 =?us-ascii?Q?R/Gm1rDFxV2ethwRgUrlp/rsDN4Ab5C58wHlL7d9kLZnmHVnn9fQLBtQOR+M?=
 =?us-ascii?Q?vqdH+WvBFfSCHVBpzJd6kZoVs3PhnpoOBJCAdNjpPAQSNCrM2YJyFKgoj3lQ?=
 =?us-ascii?Q?wMVMJpOizGfQsfwG27PeSbw4iM1RtUurJ6Pql/e9MG5HT4hUyj2/iwpd+tlm?=
 =?us-ascii?Q?nc8yjtorrV2b+OPO7mc7Pxl8aTWoUMjhBALYHPZCNSp8iIhUDSLijEKmN6Wt?=
 =?us-ascii?Q?XRdEl/HrA/fMj66Hao/Jyc6+Hx16xxbF1finB7vyqYWt3L0Fg0+O8w9XDmIj?=
 =?us-ascii?Q?O2AkA1ZLIEGxdOw/Pq/V91R5ZKlUstVk+tevTfIlh1i7KxLdBllZB+KF3Xi1?=
 =?us-ascii?Q?bha0hAjM4UmJXFNliPHWmFVfceYcJoopgsmS7BsOq+EYuPf4LWw2nNBQaiod?=
 =?us-ascii?Q?mVSdg5yVpLtfRHHVfpfk0Vf8OsC432rUu+r8Z2HzlSk30gL7BMQBXVBCyRVp?=
 =?us-ascii?Q?2dz0ZUNstOkcNMZX2JRGKb4TC6h5O1cth+l6jBlyJv6pAPDHakG1HK+Rs/tW?=
 =?us-ascii?Q?LgNMINRMUaCnEZVqndtggcEV49MP/hO5oPWTmfcm9Hb6SmZWtCwkq1lnVMUb?=
 =?us-ascii?Q?qxEhnmKUEh4pqTmZBELTNPq368erxg7FhtBLA1lwhO0ZTdwqxHFaR3ErKKnt?=
 =?us-ascii?Q?7ZXJAx6ohQVY9Lxcpc06eO22mAR6pOpdCXQfFEV/nelvxuYe9omSzeIEUZ77?=
 =?us-ascii?Q?cWcqvAjTiHxuZbndP5fZXfUcjWZHRGxLX+yOs4Nw0+IdFZO+HY7g/qRAjxP9?=
 =?us-ascii?Q?xpvvNt48Od4vauwqwYTZ4+tdFebCc4mJ9e/RGXkRIsCYPoTJCv9XueMYPcnw?=
 =?us-ascii?Q?L7Iz/mBucTNXrk97+4e8RGXWd1k0pIsa2b4epqXWX1QDRoWEzuo4Gv5Yd0QR?=
 =?us-ascii?Q?4gg9p2SfoDarIVilssl9iVvKhJ+q1MqjR8t+8dnd+tfK6h+wCxPWFr2N1Z61?=
 =?us-ascii?Q?aCwkigTCjho0AdZObL0LYWWqPV+rAfN/KgL0u/EXUmlk/P45vPu4XR+XXmrD?=
 =?us-ascii?Q?SGquBJRoLoJXNxzNIBshfi4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59854a95-babb-48b2-5d2d-08dddf3cb842
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:23:24.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XSiA87Lyby+gYON6vzjYwKMyn4cWIDUpnemC5mIFXTFdVugDhqCQAU+cMy7TR7WOVOQLZRlB5XHe2mNCzou8rPdf9BKq0w9DCZP7IrLwKXU//YoxxSJbcJfqPvAPItW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049

Hi Biju,
Thank you for your patch.

On Thu, Aug 14, 2025 at 07:41:09PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add RZ/G3E GPT support. It has multiple clocks and resets compared to
> RZ/G2L. Also prescale field width and factor for calculating prescale
> are different.
> 

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index b247a6c181d5..7047359cac63 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -153,6 +153,27 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
>  	return prescale;
>  }
>  
> +static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
> +{
> +	u32 prescaled_period_ticks;
> +	u8 prescale;
> +
> +	prescaled_period_ticks = period_ticks >> 32;
> +	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256) {
> +		prescale = 6;
> +	} else if (prescaled_period_ticks >= 256 && prescaled_period_ticks < 1024) {
> +		prescale = 8;
> +	} else if (prescaled_period_ticks >= 1024) {
> +		prescale = 10;
> +	} else {
> +		prescale = fls(prescaled_period_ticks);
> +		if (prescale > 1)
> +			prescale -= 1;
> +	}
> +
> +	return prescale;
> +}
> +
>  static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
> @@ -443,6 +464,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
>  	if (IS_ERR(rstc))
>  		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
>  
> +	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
> +
> +	clk = devm_clk_get_optional_enabled(dev, "bus");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
> +
>  	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
>  		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
> @@ -481,6 +510,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct rzg2l_gpt_info rzg3e_data = {
> +	.calculate_prescale = rzg3e_gpt_calculate_prescale,
> +	.gtcr_tpcs_mask = GENMASK(26, 23),
> +	.prescale_pow_of_two_mult_factor = 1,
> +};
> +
>  static const struct rzg2l_gpt_info rzg2l_data = {
>  	.calculate_prescale = rzg2l_gpt_calculate_prescale,
>  	.gtcr_tpcs_mask = GENMASK(26, 24),
> @@ -488,6 +523,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
>  };
>  
>  static const struct of_device_id rzg2l_gpt_of_table[] = {
> +	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
>  	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
>  	{ /* Sentinel */ }
>  };
> -- 
> 2.43.0
> 

Thanks & Regards,
Tommaso

