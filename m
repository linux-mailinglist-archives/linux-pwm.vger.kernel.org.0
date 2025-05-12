Return-Path: <linux-pwm+bounces-5886-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15999AB2F67
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 08:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F8189A69C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E012AD11;
	Mon, 12 May 2025 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="OTsTErnd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403EE134AC;
	Mon, 12 May 2025 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030538; cv=fail; b=cO8AqhYMXwZY4iofaymg8SBSRxD8CnZ+A2BSaa4JxXNykdZIB477eGnvOHswsd2oPDFbFM++I3qZzfJ2bJAg86fcXa5UgVThXypB2tzzHHXz8wvqhXhFpDx9/3ER0xPVIxKA6LW+HcJ8a75avtyQM6wSPRTuYR5/gHjRRk+xcjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030538; c=relaxed/simple;
	bh=JprujBI5M6tqdPFgZ1pRXVNn+B9OsPr7qDz00my2pKo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ty/xRM6T3tmEqH4yUuk7karkX4vob70JJ3HTq1ZUSmcNqI15qHASIFCJCAyGw3vINIGfj8EXMNcPZjStBraB9mHd6EnlRcLDmOhtdvhWW6XBsz562jdpsK/Vs7SHqgejEjSeO6WsVHSAEaIEOrRwRjrZp90Chidwy4jXkkOqebE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=OTsTErnd; arc=fail smtp.client-ip=40.107.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUb5YZfdXuexkybkkaRvpaBnKXiisbSodjXJK8gVItnypDHA7jn2Ufczs5Dd+4skxvJYakcjDSlWcphaUlA3p6Ncgd7nDzKIgCUJdMrdRTBPNV6hjIuseEwblIUo6MvllA0x5QKuxewV3Q59aKnt/BzrL2AODrIqVSIsHaVEACgJa9eeScQQlE2p58PxwxN1vepe9JGZijuJOanRr604kCbiknf13iu0EPBQtYMY+Dcm+RdiNIXMPX44mu+G0fvP3ZaQhdmK5dZNMJFzA0hFah9ROCxwitufEaE9TSNEfdTwsyCYjsmO0Cxh8bv66HLg/4jP1lk0BUvPcVOG0bkq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rd1IdsMcydFlO7/EkDN+unEsQK22MuZ4UtWcE9hw1w=;
 b=GpJWK/rtkPZASyDoMSmTU7ozUd+d8i+khljNIpmSwHWit2U27zSD7t96o81SCm900TjIV3lDo+aKMhe3TvR0ejU5IL6IYPKdlpManF6Io+A9nAGp2KWBDeVZ8gL1/QC0AIGBD2jiXEIcOC/yS6aIfIy/IHM+MQ7NWLNoVtQvK20a1GEqzddp96WZVA/4GPL9a3Rjw1inKNsOktoUcJbmMPzNhT6vfd8IRI3jhGsCokTXvwNzVyf0GkJxwX36ppxvhP5e/LCfoG3ZzKnJ0nWJxdl7i3Xg43jU2r3V9YU+wlV37hWkEd+Pi9L6uoslUQHVDdEoN1Zah2nyAUUTrjMiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rd1IdsMcydFlO7/EkDN+unEsQK22MuZ4UtWcE9hw1w=;
 b=OTsTErndHIb7qZSucu1KuaHZPMCL91KMctDKk2H8FgTojlWuH6JkfYSEijdvO6xwG5QhifldcGgFOJ1oMfi4100gDqK5DQcdkQtNHrb3y7YaEjGzNxBTEDa/bFasIcqJpdsO7F6xsRFZS6yLiIerVyKi/MYR8++35MyjZi/rPtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB14981.jpnprd01.prod.outlook.com
 (2603:1096:604:3ac::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:15:33 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:15:33 +0000
Message-ID: <878qn2xsl7.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>,
	"Catalin\ Marinas" <catalin.marinas@arm.com>,	Geert Uytterhoeven
 <geert+renesas@glider.be>,	Russell King <linux@armlinux.org.uk>,	Will
 Deacon <will@kernel.org>,	"linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>,	"linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3] pwm: tidyup PWM menu for Renesas
In-Reply-To: <TY3PR01MB11346BF34853871CF14B7BF028697A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87v7q6y9m4.wl-kuninori.morimoto.gx@renesas.com>
	<TY3PR01MB11346BF34853871CF14B7BF028697A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 12 May 2025 06:15:33 +0000
X-ClientProxiedBy: TYCPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:405:1::26) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ac7dba-43d3-40aa-dbba-08dd911c6714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9uTBizli0NDAjC5jDXywJV4vZjrFxQUoWb/NpQqNxarPmwU54gSFZ88qMHa?=
 =?us-ascii?Q?zsVh5Ddz9TFbat9MwMXqTFNtHktm5pB8K9G/OjeAzrWFuwBfaWMtc6e+EfeS?=
 =?us-ascii?Q?TlSHAHdm73YvHuwxg43hD5FA/uvTkg0i9UoWDIpM+qIT//g+3UOqIrKkW5ZU?=
 =?us-ascii?Q?LjeI82m5yp/GvoivHLgddV6pm/xw3Fq5xjFclHa+x1I8dZ6YxnOwsF9X2Yfx?=
 =?us-ascii?Q?kFGUPlnNPGR0JgJBCp5qi9JvW0NFtCMqx+EsiWr4y/xTZjTqsQVPbGWpcgnT?=
 =?us-ascii?Q?Ie9Q9YPW+eMFzoiIJPLnhusMvWPSf1kpfUKJ8XY0MvpyjRdiMWOasxnuvbzy?=
 =?us-ascii?Q?1bGzHK9LI5LZg1ZB9N4i8wqtXViaSJAT/0i4s2Wr+/Alk+t6hZdL+4JaBsvg?=
 =?us-ascii?Q?lyx3avMyqI+WlDUJjfHHRyfOZz/b04ihWDKX2Q7qpOLoWx7kiuXNqLhkz8G7?=
 =?us-ascii?Q?9q40kYoLjHaeLW24e5vImRw0XjDRPIFlIhtG2zavNjWgnYzdqAINBcmbiaoz?=
 =?us-ascii?Q?bRRwWNu2MS1a6UCmRuSM61Wks3gplL+vxArfs/wGilnIiPCDMbNFULzZZc3r?=
 =?us-ascii?Q?7OEPH/eUJVMXAuq9j7raFYcE0z8kZZMQTyrqYTylbremKLPmj1hGUakz3y1X?=
 =?us-ascii?Q?VdqTJUOIdZlX45XG0blJAggZjn82B1UABfspQMS+MLpxSII3K9onyB0T8hZF?=
 =?us-ascii?Q?jI+QPbtBshjShyZt6oJRM7Fc2NCZLdEcmSrtmSBJ5FRHTVHVfGbG7doWzunW?=
 =?us-ascii?Q?jdc43EKXAebxeWPQFp8yruPJfnRzqu6KuFRwqhrn5QzeGMygyUZhJcdiYoB5?=
 =?us-ascii?Q?YnPxw+WqrJ8bSSsBYff1TLyLRcCSfePgA9ct03JM1p3I1AXkBUVGQZYRgYfL?=
 =?us-ascii?Q?4IOWKYalEAr+xGjWrVwgWKLKz44mL7du9g9HBCM7+SDJsoU5w2JHlZoiovFA?=
 =?us-ascii?Q?Mw+boFAL6f0XDQQUxVVJlJcF1J1BBc124zfk0oY2M9VOpqHMRrX2RnoYc5Yc?=
 =?us-ascii?Q?yKuzHc4piu8yQkPP3bqKGPb6DfKW3L/0G4XFHtKlThDxAapYtMBUM84pm9MF?=
 =?us-ascii?Q?yUcdNzhsyryXFnzoJ/7TzaEfj3Pjtjfb45oloa0AZMfMy8Mm+oKT53PiqqXO?=
 =?us-ascii?Q?Q1bN9zKjkaJU6DUgrucBrINI7KUpoW1HlS7CD5VDEFfvNSyiLcuO0NYwo11J?=
 =?us-ascii?Q?/buBV3Lc0fiUDOzOzfFrD3wW4ojXgzPxvVhM9EUvprVKJAOJUaRtWz2w1Bhr?=
 =?us-ascii?Q?bU2pKZWaYpm3IZySjTDnn1M3mtDp/fkMP9OvhhqHi6AXnieH7ZGg2sZSD+aC?=
 =?us-ascii?Q?ZwepnjV7AJhqgFf3oulsvKMtK8toSZLtpIiPwkyj0tEuVr+9f40NjkPHMl8D?=
 =?us-ascii?Q?I+e3WPOWy4cmzU69NR4MGm6ahGS1TS0VSaOgr55FEWNWNcrtjRTmbsX0Yiqw?=
 =?us-ascii?Q?fFQkKxRr/G4rM3PzIQGjcmHbPBaOAMR75JtCdvM2t8SghV2U2Vozzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nx+vQqtZrEFk5yo3TlNWKb8dk+ZsAZMaqmrG5XGlNs4P2mnIZ1B+Sm/FCnu9?=
 =?us-ascii?Q?BTsu2o8lac4sMhbONV6UwSuXQM+B6gwbxzteLXTSBKVGTp9jUMhai2MR19PW?=
 =?us-ascii?Q?4VDZDKmSM5nTeBsUN9o7MxLEjDPBbKumqbPahF9FKmpSCsT92csFfe7737nn?=
 =?us-ascii?Q?91d0QNS6SkzxOdBvqYxA3Pms8srxsTUiu+DaDbhI5ObiZuvf4+JWMLb9F1yI?=
 =?us-ascii?Q?RI79KhMf2x4rS/leunKQBOk+NSU53A3eG0ivBg8dHobDZYnyeOO17Q/TtjRl?=
 =?us-ascii?Q?jcvYDMTa5J9e+IWItrwJXSs2D4Ua4m3saPbV8JGAYVwgWsnHbMIZhLa++COO?=
 =?us-ascii?Q?aZXhzBGOO57aDDm+Y8nzaI62W5JDB+AseCy7ZcFI1DlQtrhroj8HG4n7Mqsg?=
 =?us-ascii?Q?pKIsMfs6kkd6uh5iGEoQDTV6V/cXHSrt1+4ww7UOZKrBQb3nRSsvTHuTuoC7?=
 =?us-ascii?Q?nVqBiYinrQHw4n06XZRw0aP7Cayi+uxJko6xpowfl9DGGaKYNK6hYkd90xTe?=
 =?us-ascii?Q?oHeK+pwGJYVkOO9uYKziJq+Kut3f1Sr4WModV/FjqOleOisj22XcDHj2KUvM?=
 =?us-ascii?Q?00d7Lr0U+r8hk2bHuzC/DBwoRuRrn81b9c5qsLUtuaVYUfpf05LhdfKncOKy?=
 =?us-ascii?Q?1dmrJl8JbirN/Tj+L0/md1pJigL0/ziuU1LBbNktsaG4ZBjRo7de5IOg7GTp?=
 =?us-ascii?Q?BV5HGIzccKANGfLFcS+t9jpnrrJKZtdSZVoAK/a4lyOGc9RPou5H3acHHJaE?=
 =?us-ascii?Q?Ns3DN/KCgYGlkUjl5aj3MHqUobZtSFlPYAlQL/4+TkNUkOoaR+0BibgqHGaR?=
 =?us-ascii?Q?5ugYXUcxZqswAyn48+TgrBU+ILfaTwISgvV8GizlqM08a7kef5Zig6Q+7wUO?=
 =?us-ascii?Q?LsMQ4FWXpzc2YfLJxQr7r5olpPRZN2qGtSU9OVP09LgQOloJ+96/0/fKdmdF?=
 =?us-ascii?Q?R5HRWXky5raaaK8hzV2dTzPRSFvANVSVt4kYVOC2oM/Jxs/g196nvDrKI/TA?=
 =?us-ascii?Q?T/fKFrS369K+BesuqPYq5cqCP+s23r2hdmWUtQC7ticx0KqBZ99ZF/y+EMFj?=
 =?us-ascii?Q?bOY4eO19bUNcSC79CuWfoCsOO6Y3CkCmIU+GVf0QStqr7T8XUgSZjnH9yTrc?=
 =?us-ascii?Q?pqP8d6j9vOV91J4082UDBhx/1lm93cUBoZRoWR2iF4e2to0NaKkJIRwJG0Lv?=
 =?us-ascii?Q?+yhpOM9w33AUQVSUicwjLG9b4Xd2AYQ8yEqE/bOp/pW/lUpq3Egy7nYovB8q?=
 =?us-ascii?Q?uFlDQOvh2cicv3wZWAw7c5gcEH7cyBPaH5eHWxJRBSRz0lmw5zpORuQZZrfN?=
 =?us-ascii?Q?8XMFwP6L0Z3E/aY76XbtEIfgn+YDy/9tQEI2LBKffWvy1LdlKflS+hGYi2VF?=
 =?us-ascii?Q?41181+shnpqqgCfcx810MPw4dEYy6vekZGOjmVegdwE446xBhFZh26Vl77VW?=
 =?us-ascii?Q?WHLklefJr6p8nUaX4JnUL+YlbxXudLRJbGl7Y04vLq+H78ka6lKb86XrkV6I?=
 =?us-ascii?Q?HjSLHXn4wh2rETII75x2RNlzVssr/w+gURrWxouabsEI6fPOCPURG20cmBeu?=
 =?us-ascii?Q?AiaqrcmAp2ozKKDQ7YW7Q0NkxZbsysPdgCKaaD6XcixhFJOshigpya+4Mm+D?=
 =?us-ascii?Q?KjC2VYYYjsCGb5TgWGehk7Q=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ac7dba-43d3-40aa-dbba-08dd911c6714
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:15:33.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckivTmKYRKuJsxWsjrpu3ivzs34/YW5K1Fb10RDNPDj9Si5Hd+FTE0bEKA6tkvytld2HhTDTpzpOa/n6PpRBXThINOm7PrtdzX/NwBJzAokjMEkfTV4usLLZVDJhNhR7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981


Hi Biju

Thank you for the comment

> > -----Original Message-----
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Subject: [PATCH v3] pwm: tidyup PWM menu for Renesas
> > 
> > Because current PWM Kconfig is sorting by symbol name, it looks strange ordering in menuconfig.
> > 
> > =>	[ ]   Renesas R-Car PWM support
> > =>	[ ]   Renesas TPU PWM support
> > 	[ ]   Rockchip PWM support
> > =>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
> > 
> > Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas, and sort it.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
(snip)
> Do we need to tidy up this as well [1]?
> 
> CONFIG_PWM_RZG2L_GPT-> CONFIG_PWM_RENESAS_RZG2L_GPT

Ah, I didn't know this, but could find on linux-next/master.
OK, Let's care it too.
Will post v4


Thank you for your help !!

Best regards
---
Kuninori Morimoto

