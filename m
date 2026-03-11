Return-Path: <linux-pwm+bounces-8233-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KWxEbyLsWnkDAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8233-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 16:35:24 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D724D266A4A
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 16:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50D693020A60
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE233D8110;
	Wed, 11 Mar 2026 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAgwiqqm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237D3DF012;
	Wed, 11 Mar 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243321; cv=fail; b=iJj1llSKYmEqWwNZttNa+w/g942gD9Rmp5TTYXMNzlDH156XjDO8XungvJiFVf1um6mw/01rQ4dGBsWB2MgosolHyV4s4I7G/QOIle9w0nB+9NnLeVYH0skyrYD6gEIZR1zysGQbZsKBJU3rRN7camAoHPNtX40mBiw2IPkwMNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243321; c=relaxed/simple;
	bh=GP4Prr6Rw0rOpWfni0pz1MSJDc0RvXK5QJ/reZcXGeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y4ACdcGOzIEgwTRoELSjkHtbp7GpGcGOSp5lQMUI1G41jFjpmOLuccUTlvGMJbYxxlNpkc34Qg7IjVswOG4EuIW6eUmHGgbs0JpVVOxqViF1HC6MVLQqmZaLzDo6Ez3bON0Q23amKV2wLPsQ1inayGYBZB4nkg7297N/IW8wsdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oAgwiqqm; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+yWAAhjTCpkfItRsluNIROW86u3L2ACbgJcYuePG+ReigjbIiKKxWBSwQ6E8WZ482ScLLJA5DFj8P8ZPOhwVTesTg93XBKBmjP8FRPTQ0YqYricD9cpFJh3Ow3BSywjZJUwy4dP3+dJAjlsACjeDG8MyW6G3DhAvAZ+8Sd1JVNUhGkHejBJrA0hjud/jrSsUgh48MoLo08nG8Cm4ycMneffJmqNwhyvsJJOzg6eDuJpUjBf39UFUWyoQHxzKomzsy/q7bQZLzHdVAchL+gnW2rrQfK7BS3mVEylb+NwzP9MHsms9zU/O0QZ63c2O9VHywXieDZkfeQje5ntCmLf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQRdV5PLel6wdttXcoupgzmcBBFBNPD9UQib1hBH3kw=;
 b=LM4szPr0k1P8UO/B00xXnMSFvQumL4IuinpAcygc+pOwyRn3CWQl/VXLCP7DYf0L/rsKlw/TRpjV3Uo2ntqYggVa7EcWLzqnflLdtwv0SAA1chHNpRJp55Nh804uDsCu7DlynVh5NwCEtS9GB7/VIFNmPXCvFpwPvvze+7UqwAgQUTuM17dyUFiIAGxx4wbelkDoyctbNY1Nqo5w0urMnZPqzgZ78h+9yngJ05FaON+qnKUKtsn82Qn/d1cCJQGLIw1XGgaL7o1jQaHn19x4PrPRLvnZ4WMhh9fdMhi6lDDsfBqyaNEwllYIVBhmLHeLw2iU7qy3vu+lySstsaGmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQRdV5PLel6wdttXcoupgzmcBBFBNPD9UQib1hBH3kw=;
 b=oAgwiqqmgZ7XiaIUl8MuIDG5WFeXAQrdu3KWW8lDVUYVaQVHJtyvsWGMLWjHMTirVF8QhNJMDZmrw4zWI34qDX77XGjxoncEXdJBOPCH+6gyjlZbK5Dah2XXTDqP7C4fqGBiXgWRjD+KnvG9TWOufpDOfSGV0NDrUkdRP8KmRestkLJYBkzIUPo3Wv4Dp+mBrMBDo3qWrwjHk31wg+000jKqfN8XwvQ1Lmi4nsX0EChCQOi5OSBXojxTeImEslyyafgK2oTgo3DmvIJF6CwSFCtpC0F++3SU9ZGDcjp4kUSFLLhhRhAsRb/AvOCoEhMXkmUHwdB8K7FZvTO9wdBQ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 15:35:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Wed, 11 Mar 2026
 15:35:16 +0000
Date: Wed, 11 Mar 2026 11:35:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: imx-tpm: count the number of enabled channels in
 probe
Message-ID: <abGLriw_VJ0MadPB@lizhi-Precision-Tower-5810>
References: <20260311123309.348904-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311123309.348904-1-viorel.suman@oss.nxp.com>
X-ClientProxiedBy: SA9PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:806:27::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ba6521-7417-4026-ca84-08de7f83cb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7dxM3ztrJSrhn3XuCIq0jKRr4eotAn00J95biGih54b0ALOCCyyNBNdDb3LTYySXIJmFX0Thej4EXFxD+uaIRyaIEnBi6g0vA/HADBOMMxsyGh87KLMNRiDIekyLHet0PCUKoBzzGtoGsspOlDhSO3VWhsJR/QQcKmHApO8cf2JhoRQOaNe32K/p2+lAQwZlXWOWTWsc4SUXaoMDZx1jmyv2Syf43oUjybyDK/bo0DATG0Tj4ko6GS7p2Q4pMPtxEwwCgizpqe5SxTIRCf4GQtiGBVzIY+7sfVC6xrMCvM1PJds6RwR6mP7aLGZkXT6XMWrUANatIMMWfZi5JKx9o+J2fD4VKUGXlblv3SLafT5/9IaTbW0enitDOw31+5tm1Y8fcyxbbxZMYlcVUid4DsoDvjKOR9gXGS79rQolRsSvcTVkUt5Kq5ky+OEfTCI7qc3Xf5JL8YDzqKxBoXWp+qF47ZL+qHmqvalT8S0/uirkySD5wBvmxogGqZZALprqN3Mn615mNHJma5K+pgHhiXZDcuHTIFN8PaHeF/t8FMbWorNaH8MD98oNllQpgYzPAMwEAGtw+85tcLRpNi/YMT0+ptwaLQW4YfY8knS933PNKSFIi2IHJ7/yT1m3SduSxEj9A8pmYewvU0fk7FZ3cOxcCIyDmYQkOv9QNJe5TSUdYJhYmaIajdggMwiqmUqWMwNJ4XCBdOo1RhOWfVV4u8dQ2CsSgSipFq03BzApqmTMhYIis0T5byuL0S8vpxO+FsWl4FJ90lgVHFgj/uZKaoUsc0+QRDoayRUtRJuanas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAC9UW+EStMT/7N7253ksV5qq6mCwrhyu0QVf6501e+LdR+i13NPC2mIfOzq?=
 =?us-ascii?Q?rnZ2RHichKCOWjNFGjCf/vT90aucsVcEaGv9zbWGIkrt0Ax+MZS8vUvVe0Ci?=
 =?us-ascii?Q?/3CpYLvYxnzh6uYE5LsEO3hJhDwDs9iaCXI9DkCA2E7OQcAUPSbKuG/dpP5x?=
 =?us-ascii?Q?M6khD/S4uBEcHHqT2qIIV3NQk0Nx+8HsbZr1gDdZQNBTaGgu+6CRIi3BkYQD?=
 =?us-ascii?Q?zFluXfJ7E2058CF/+rugr9O7A2HMOlTlY0r0LdWyhAsHHynlA6cvc5paZpl9?=
 =?us-ascii?Q?J0rHWyaNJz20OHnqiQ+qIxthQZOntRO9UIoYIxc+8TYwNp1nrkZTw1XcPVVz?=
 =?us-ascii?Q?43rMYGGLXutLZEilr38QHIhs9rvbhKcfvwjG/7QsVhynKovAfCyaXfe2MNSD?=
 =?us-ascii?Q?6DyKYw4FleXk5nvc0sj71/Inp7m0ek58otiPZt9eje3fIuYL8QawBOC8MUQ2?=
 =?us-ascii?Q?Omu0IoTDzuRf0JF/fM1I8EaR16NUj/kvCikAIa4mkHarYFKZAs1JA9xD6i6j?=
 =?us-ascii?Q?ZBaO9BYdLeW869XQmglHdUiYXs5lezD9loUhGwf8mT6Gb7jIaNeGTtosecv0?=
 =?us-ascii?Q?eY+ghsNrgwaz/OHU+Zb+E4ASs8GEX1ABOZj7/6VxuNCqD/WQRUty2rommlJ4?=
 =?us-ascii?Q?6eM0TLZYciBKCcJ5G5DoTJasK9Wcol1lOdjgaSjrB+hOhVW7tQYyDZXRFdmM?=
 =?us-ascii?Q?/qHF5E4uQiZ1Bt7QpU+VDFcxn/dzI3M0sW7U3RqNOYCO0PPdOorKBWi8iAwq?=
 =?us-ascii?Q?kl4GzTP/DcRnbrMDupX4VDWvfnS0iYjnEANNZt8zX1t/lYxyIdiD3ixRHpCg?=
 =?us-ascii?Q?AVhS+B1/Ss2x5eO6wsumK4cdHFppybwLSMT4RMp4m0OMMTQb//8jQ6daG1Qa?=
 =?us-ascii?Q?dayYiUgxPuDB7lYjSJRGpawUwk0cx7Y1k8z4GaJfQ75wlNTcC3WwUynRxZJw?=
 =?us-ascii?Q?gHi3WBUXrbm2jY5KnKwliwh6ZxvcSrwWmdzf+6qtbxzvUjVFljrHmGl2Q0vS?=
 =?us-ascii?Q?mQJxLfGgqSAjXkSTd0N37+rHI2iCpNYGzet+um8G+0hwhwbZ9XFspk3SmF2c?=
 =?us-ascii?Q?Iq63JM4ezafPmmTReyAapiQtKjX7+P8gzSnIrrIMjSfEDEQzkpB9T4/9ajVG?=
 =?us-ascii?Q?LYTO1+YDv8RHifF7Na2k9Gry58Zw3F8/LhbeMB87F3gkD7Ow6ooMrfveF1j/?=
 =?us-ascii?Q?oi4cEcubfBQSkGi8ZoLfLVkbhY/ro8GCsb2ukuXS/S5vhG7QvjPvaHUZhfYS?=
 =?us-ascii?Q?tacqxFwBYm0QXNCtOq/9IJrhoxEdtpSl2DFMYRPl4ZliJoPAqzIxx7/qUO5Z?=
 =?us-ascii?Q?J++D/XepXEULbMkyinYE9vRIl4zKdZCYtrrdfy1CQkUW7XGEvecCBAvtg9Vu?=
 =?us-ascii?Q?PL7YgG6I6dmGZkIV7PnmF7a+1BQLahqWje7cQAPghJLwqeVcohIm+ZIx4oJo?=
 =?us-ascii?Q?hpjkdhiM0kLmLP5RFptH2TGgZ/XkEu8tXPrK0qqQ5T9+dqvH+46u7RGbJ3db?=
 =?us-ascii?Q?NH0ofmZpRLP9USqZ95RzNGt0uH7w7WdLKfA69/Gm09JIxbJ4fRCRMD8V/qy/?=
 =?us-ascii?Q?JbexcJWPnOAKQfOEbbIc1Ms0173fDMp4+iOExKVPmYyUyDKmtO0Vbj5RY/Zu?=
 =?us-ascii?Q?fS2PL9XjAojCgQMmqd12HPMbDLZ7h24RrVo7e4I46AgI8aelf9YBYlLC5aUA?=
 =?us-ascii?Q?MqjN4a+avZuMybHLmLSXRuIsxIVjffOXil7wIG8D4KUFSYj0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ba6521-7417-4026-ca84-08de7f83cb57
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:35:16.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiRe7J3rd2mhd1YPaDAAyOEW9/GrINJkde4Ht864gqa8z+wLmtwK8N5ZzezBk2/CVWnPT/heKecXL0ZDFppxGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8216
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8233-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: D724D266A4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 02:33:09PM +0200, Viorel Suman (OSS) wrote:
> On a soft reset TPM PWM IP may preserve its internal state from
> previous runtime, therefore on a subsequent OS boot and driver
> probe "enable_count" value and TPM PWM IP internal channels
> "enabled" states may get unaligned. In consequence on a suspend/resume
> cycle the call "if (--tpm->enable_count == 0)" may lead to
> "enable_count" overflow the system being blocked from entering
> suspend due to:
>
>    if (tpm->enable_count > 0)
>        return -EBUSY;
>
> Fix the problem by counting the enabled channels in probe function.

Fix tag here

Frank
>
> Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 5b399de16d60..80fdb3303400 100644
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
> @@ -382,6 +382,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
>
>  	mutex_init(&tpm->lock);
>
> +	/* count the enabled channels */
> +	for (i = 0; i < npwm; ++i) {
> +		val = readl(base + PWM_IMX_TPM_CnSC(i));
> +		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
> +			++tpm->enable_count;
> +	}
> +
>  	ret = devm_pwmchip_add(&pdev->dev, chip);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> --
> 2.34.1
>

