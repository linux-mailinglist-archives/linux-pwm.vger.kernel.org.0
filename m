Return-Path: <linux-pwm+bounces-8228-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGzeCmlIsWlCtAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8228-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 11:48:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CB262843
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460483184506
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03993CCFAA;
	Wed, 11 Mar 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z53visux"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF43CB2F0;
	Wed, 11 Mar 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224733; cv=fail; b=hZVIAEdvWFaZhxyMtxDEkV3FwVkSJoKYes0hE0Ua+JOByxhXXc0GEUD9TsbL2o6BGPcyReGuUltXcRvN5e0zxYGFQ7U0d7toXYKawwzLIVVthEExJ3L6m3sTfzRIXHM1tDjvxcvBM+mwN/Li8dUHDL+Ql3ycR4UBfXeuGjU1U/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224733; c=relaxed/simple;
	bh=Evt2UdgmYKkUbC9nPMJMDyd8ImrTjnjMCthyOZHNcCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1Tv6cyECT6oTXSZIr7R1RXMFvp1XMHwdybeaKu+dB5UgVh7t2tvFWN6mLndDZ9HB3L5yccSaSXNiqj9mZBYWTTQsakHqxLIz3XNyn1P2bsQk09UNL+xGHwhrMcKgTqx3/zx02FI80JN8dB3Y7yy6gS0VIMuvk6QcSe0yl2mEnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z53visux reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+3HhhoQga5a3OjSEQfVsrY2ULW+5bf2R7M++Az0A4MnpJ6gCyZyZ1LEIbNnLwXONazWjLMWwevgnNAzP+rqD6YpIDglQDw1jrMbtvH/jgHaxs50YT4O4bz+lSWWFo8HSnk7aNaFyxSUWmfgG1+Okq/8taaQjOqEJEg5hyFw9KI56Tm0JjeNOzBNAMBgROpesSaqs9/Yj84sXLLZUj6gO2vXCuGz48GCFd3ySzE8Y2JXQ5KYOYX1MxZZxqTgBEQkURyCV7GJtly+nLCYpAoNNC1XatGxemgNCeBkqLp/AJ5byOC1SpSPUGNeopUK+swaSmEvzzj18RTScswWBPP35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnjhAOTVIxbzXYCENYE39Io84Rqg/+4FoSG8aSU53Ew=;
 b=r0sCqesVms8pTKue8gmFQVf6F7ISmdVYMpgqNBYktAiAKTu6Yv1zkeKhLQHB75ytiKHuDR+p7jVNQibnEjcyJcMwv2Tts7uJTjQRcxXfrYmNWgCwMgo7+M5Yqc2HOKSmhPZ4lPIk/K7vsbV5JtwWVLNQlJdfnc9+rWUtXJ0urz6vPyFx04nj1zdgUTVpUau2xDWAt3ib/4ltZZxTd0dyeCK1t8b+nha1XDiR1kYFhvxkqYAlO85LslyfWF4kwrFkFdSTXyjHFNVmRKhTG9VlSJEk+S6eZt6Bhz6FKcK3PxvSL3pRxxAWwmxIGXa3NJbKs50pzhRyCW1uNkt39v6B0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnjhAOTVIxbzXYCENYE39Io84Rqg/+4FoSG8aSU53Ew=;
 b=Z53visuxPv3BmsHKjtyn/LAgz553U3AO805Nr1ivHPU5zu/ZXZ2B1/ppusOehNnD5E3Pekg7/aSiW4z8yAmrnToCss+DXDXeYmW5pTVhMtZbCMwAcEvGB1PBss4QLTZ1gfKXAxTe2i3MEcwi6TkiOQ4dkWa3aprgTt9S7eUohPwjDHH1n2/ywQD8C7v61kQ578ONSdCs4HEb7/dZ/ITkH5DIMb3cH3pXTSsueDQrxXw6nW9crJSl8fuSG4pzh6zYknyLg+vHs0qvJNsRDBoRwTg5f9IaTC4aoIpFZNEGDSnkyPxxH5y2zUmoeIi7fICQjQVYzHEyDdcaWO1qyVn5Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8248.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::12)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 10:25:27 +0000
Received: from AS8PR04MB8248.eurprd04.prod.outlook.com
 ([fe80::7ad8:3e76:dc79:4082]) by AS8PR04MB8248.eurprd04.prod.outlook.com
 ([fe80::7ad8:3e76:dc79:4082%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:25:26 +0000
Date: Wed, 11 Mar 2026 12:25:20 +0200
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx-tpm: keep channel state instead of counting
Message-ID: <abFBVBDf7lOAUEs-@fsr-ub1664-116>
References: <20260202104738.837016-1-viorel.suman@oss.nxp.com>
 <aalMdTmQd075dcF1@monoceros>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aalMdTmQd075dcF1@monoceros>
X-ClientProxiedBy: AM9P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::14) To AS8PR04MB8248.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fd::12)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8248:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: eb667d50-d965-45fb-858e-08de7f5881f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZtmrbpAz4J5X0Ye3/28y1jfordrLMjwAfgm1IzLk/82taq1QgzlPYqZTNlgkMR8fvoJ7Dy/YdlhHZGdB1nMpMkpcN/wijBfmjQpZUH983ofCNk+//Ukviq3Qmbv/WGvDMSwtr/KtdHXYoZe7UNSTYB69SJ2C+maSzGYqn+2pEgHMF6T01nhZyCeExcmlvwT7j875BU5sz9ltHFbMcXvLcw2OasTUIZbL1hmqTBzJ/XLKo49NMsRjitm0jxPXoGOYzNdB1Nas4xaEjyWgnj2f9TcDa7pNTO2ULWuQx6xLRqft4Cf7e6DPS00ba4AJcqP43jQJhdssYpspSs3j3rrdLxz6lWpBYFItwvi1+GMDya77UtfVcY3bF4FZCn8HyD06DUsqv0L/4WlqQThm9y7CMAxNKr5NN0QKIm7Sv5AoGGcmJ6KpWZoaSt40XhRyD4vLCZ8z4AKtFhGeoG+YByg22srdD7O938Ch6lMa4icr0Zmpc5xfDuIxKlT0CzmmnaAUiTpD5i8rqTS7488Pn/Z90ijmhiC7M0wJoAl5U3WM7gHRmXZ+KbMN+uIMGQx/yM9D04hOCm4EH+ksDsDwCu8Il6MbcKcyjCbLHaqp/klJ23JA3maFzTW75r2tzNu0nKIs0h+HUZPx8noqFajUVktOkV8MfREHe0InfhaU8lzWypCVI0I2utU8xavfz8GWpxvkbreTTg4/6gztyH5JlLppVmDodbJFyFWmSe/Jw2MGmZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8248.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ruixiIT5T6gOaacYa96qlxwe9j+g8hyInOgiubMSK8AM0tKEmeJTlcZYSG?=
 =?iso-8859-1?Q?lPXUVmMdoJnXClUxrc/zWlWAWTMNBn8AGWaZeNL6TJe5SWm8d9RlgIf11U?=
 =?iso-8859-1?Q?qJqMdoGMZq1yI19QV2JAWCCsyG8UrYdVyPdxw/bxIeqJchs0TDs10L82co?=
 =?iso-8859-1?Q?/ABP8R3T8Fa4Y9zKFPjSmAFPCHq5fNFg681/hceRuM8Mt9k1TrKO21+ipj?=
 =?iso-8859-1?Q?SNuSg/bNBxVgZoBBeBibF05b0DPcTPtiG+EG6dMpgAlA35vFVj/2ruQP59?=
 =?iso-8859-1?Q?NkIONwGikGbsA7e4UyK41rdLPohPNXRBC8kta1Vdt8ntFzY9oUcIEFMmv5?=
 =?iso-8859-1?Q?zVdime7RWIxfkNWeNis6/rDn7AcAZF/Io/cgzIumACyNcafdm15QUiR+xu?=
 =?iso-8859-1?Q?ndD2+Hy1RMd1qrIoBS+dldabRBlohEq3A/3KiQBd1bCw39+H4D15fVNZkL?=
 =?iso-8859-1?Q?g7meNPaqEpZzT6YX/MyJpJv6IDj8XmCUmgbONgJl5dOm+0+fu6FgpSp1EE?=
 =?iso-8859-1?Q?UbVqmnya03wPx8umj06swsECYGgS2+j5t1FjotIZDugQR+c1UzK9YOK2jI?=
 =?iso-8859-1?Q?IYg9GXntKAOdk2ql6IheKEWH0yekRkzxXKgmtIGHA31TkUqOi+VjJsJ5RV?=
 =?iso-8859-1?Q?ByTH/bWLs2VseYkRnNzNhvFOdWpSyH0Oqi6fuHC2Ey3yTim7QBsROzGEIN?=
 =?iso-8859-1?Q?xKxfyyouR46IWUnuiRk/c9I6ibfUTuZGz9Qgp/yuBmomsWuXDx6whe8taf?=
 =?iso-8859-1?Q?M9rZ9LN7kjx535ZypzMACsKWLM+Jr1fRVMWv7h8wPX43IMgj1vQJkDMWnw?=
 =?iso-8859-1?Q?B6DN0IUCa2Et3zSd7Ip+TOI8lWFGVHco+PWzv4S0gan53Der3frwSFRs72?=
 =?iso-8859-1?Q?Y4TKWxvg0fdfN4zpVq6nB3Ym35mRj2XZn/nAycgsEg+rO4ZQyZVlN3x4mX?=
 =?iso-8859-1?Q?AvG1ncwG+Ggsvaj36M3TGOGUnkpY9Ows8Gn7hU1H/80IrCc6kDXygNG6Db?=
 =?iso-8859-1?Q?QIuEJ4L1rVSwY540Nwx1pXh8Pny/TgMnKkPsvhp+ENU+szegP8qUrRgO3e?=
 =?iso-8859-1?Q?qC+7QQzK+kKzx3X8VjUfUOfAlZKm0YikfxbwB6SP6E8QXbI7FOEiNWZhts?=
 =?iso-8859-1?Q?HhIE6H8hjYqFUw6f4AYzU2c1AEIhjdvq+QfqLW33Wg+MlCOe/M2z0qIu+e?=
 =?iso-8859-1?Q?czyw565CsWn6yKkYNsAWryRdSfuP+2PiP24HHv4o1obHB6R9T8Pbdnm8IT?=
 =?iso-8859-1?Q?3jCr88zFW6iSz1LgM9qB0p2qnloVcZBel+Cw+n8dR+4qZgbtZuUjij6ZKb?=
 =?iso-8859-1?Q?iGVfFc8XipJQdYH9A8EejhkDu1EK8oFrKlAzVyw7wEhDZYcZS5utEvgKgS?=
 =?iso-8859-1?Q?8B5wktxZcHp5NIBwS7Tr1/zbtfsr9GN9pXDNvlBe06Cc1erJ3Wl23aYG/B?=
 =?iso-8859-1?Q?F88hdCNk047WlhBjhCQTORKSlO8yhyCCXb06el+6W4jHotdloUso9pfWsi?=
 =?iso-8859-1?Q?UN2EwmJ5454dVOO+HK3vVs8c2F4vcaHdWafFL9r8I7KQHUA78gGqbCeVMy?=
 =?iso-8859-1?Q?DZqK9PVeo9hSuvxr2lTEayx0zgf1zoJebfQJ/ciGjfOjc5tJ6w2kiBM/8f?=
 =?iso-8859-1?Q?coYH7R0NDqkQ7WlZVozUww/nTrjz/+V0i4dLWvUts2diu9fsy24iUxQs/u?=
 =?iso-8859-1?Q?tHULISAxAWlSzkv9QOhq/BnTbzLXmzDmMvRbUtYTQ2ax3f4V4v2A5uPQXb?=
 =?iso-8859-1?Q?4IwOP27GW1jWUKGadMrO7uX6DkIXcWsSkZBZu6Qx77+pCYoxbPlcM55rtk?=
 =?iso-8859-1?Q?LZFzPnOwKQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb667d50-d965-45fb-858e-08de7f5881f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8248.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:25:25.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEDlJpBsl9aeShMmvB9QadqMi1twAM5gEtvz+rjS6BZy94RmkactJMU4lM68wn5kflXo/Llo20lG+4U4m61/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867
X-Rspamd-Queue-Id: A20CB262843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8228-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[viorel.suman@oss.nxp.com,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.884];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

On 26-03-05 10:29:21, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 02, 2026 at 12:47:38PM +0200, Viorel Suman (OSS) wrote:
> > On a soft reset TPM PWM IP may preserve its internal state from
> > previous runtime, therefore on a subsequent OS boot and driver
> > probe "enable_count" value and TPM PWM IP internal channels
> > "enabled" states may get unaligned. In consequence on a suspend/resume
> > cycle the call "if (--tpm->enable_count == 0)" may lead to
> > "enable_count" overflow the system being blocked from entering
> > suspend due to:
> > 
> >    if (tpm->enable_count > 0)
> >        return -EBUSY;
> > 
> > Fix the problem by replacing counting logic with per-channel state
> > handling and by aligning IP and driver state at probe.
> > 
> > Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
> 
> I wonder if the following change would be enough:
> 
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 5b399de16d60..36f873133f94 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -352,7 +352,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	void __iomem *base;
>  	int ret;
> -	unsigned int npwm;
> +	unsigned int i, npwm;
>  	u32 val;
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
> @@ -382,6 +382,12 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
>  
>  	mutex_init(&tpm->lock);
>  
> +	for (i = 0; i < npwm; ++i) {
> +		val = readl(base + PWM_IMX_TPM_CnSC(i));
> +		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
> +			++tpm->enable_count;
> +	}
> +

Yes, the change above would be enough, will send v3.

Regards,
Viorel

