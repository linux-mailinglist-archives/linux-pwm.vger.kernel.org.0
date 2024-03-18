Return-Path: <linux-pwm+bounces-1793-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6B87E415
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 08:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74621B20AF4
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316C224CE;
	Mon, 18 Mar 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="yrBnz3qG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2112.outbound.protection.outlook.com [40.107.135.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD738814
	for <linux-pwm@vger.kernel.org>; Mon, 18 Mar 2024 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746943; cv=fail; b=XxfGY5NQhiu9jn4gXOy6LdtVophruSYy6AS9PRtp7BDwRP2WPHbi50Qt0UN9l/vRMRz3lkxycYnZeb/7a+NcO7VfVugInxhNb5jZmrZPSg0khs1JDmwOfDo+/QeDV8UBlvwK+3qBM3woSIZEuKzuVZR+Ir46bApGRAIE80Eskc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746943; c=relaxed/simple;
	bh=Y2DbYhRcsdcqKOpf5k3x6VpC8dHUeuZBZzgOn62LSGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PALCb8s2WMLH5ZdLH6FoxNAlD7Z2am2azn6nwKsknyc6U9PntJwZ+xWsTPGV9DPSioZRNUu4bGAzpOd3wcNG7Ax9YT1xxxE7aTuCBuxFyFxwHLLtK5/KqY/JCJg8rjUhC1sPt+ewXVireFbnZgJOThEIhvGSrzDHoOwnM4o7GMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=yrBnz3qG; arc=fail smtp.client-ip=40.107.135.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAEu5OoRZJMhQcBIdrtLzeCZ/WYG4EHH7KKICeOx1Uj7JVDY2kULd2GBvgBBHtQUy7RR6HBEtwmNOum9Mt4wh0dIORw/mM+CWfqMpoh1PQZnrcx8+h3wg2f5Xf94j+qVavej6tGxCCbmkttrWHDonrhoWpHGZlkKrIbfVLGSVG39YxKXrah1aHn5zUDgv9u4wd5iWp6Yk1XhXZp/HJ5JjwOkt0ncA1rSzlbA77OEeAsUtgebmuf36fz7MfoimS42ANNQ5Gjm2mik/Bz+DAyzol9pN/GLH/IcpjdaMw3pKeR0bwcUpuXM5lvNrfEkwxfJ941fOJAiQJdA3QMOiHKzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS4Q8GFFPAVLoFk1E7niM9433Qo29i1nWkSbowNNcAk=;
 b=CdaeU+BsjnF7iDeBXxO4j0azziWsg9uZhyTDkFLMyqBdb+emkc/wVuZEeRb2MfZx8kWTVmx08U3ZklMaB4/6nWcRpiSbnx7umG+7+5uPo6+0s/kS92yTc7cEhrM6ZQpgXyxb3q0Lz8lUf9nDYfBsJc7mJKewYyg83QUDwQoNVCDaxZxAvEZmL0C28JtknZ5qvCWOAIgaSQYeA/oPHjHdrbiaes48++suWfKUWwEShWoaD2uvdC2aGr8e1uEs52+7A/Ju7nrQhk05/FhUFZZ5lfkF8fRIzyt4MyKpOVvHdIaILrScMtPNSEQaVGn17BRjTw7KQJyVXqTHdiDlvKk9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS4Q8GFFPAVLoFk1E7niM9433Qo29i1nWkSbowNNcAk=;
 b=yrBnz3qG/+B7MfJZm9+ou2nPXr4337tOEJWRRSQLH6KK2zxJJbp6k/AR9DFbBn/DmypHpeE6kE2AekfR8d/t57ZRkqAg0qDBcVkAKQwzc96ZvGJ0SoySLxHr98WYiMAJpFWqEhvq2vb4Wo46+BMU869KyuwYUKl6h7tIYWn37ak=
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by BEZP281MB2915.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 07:28:56 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f812:c649:c5e1:509c]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f812:c649:c5e1:509c%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 07:28:56 +0000
Date: Mon, 18 Mar 2024 08:28:54 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 7/8] pwm: Add more locking
Message-ID: <my6ojx6ragzocxp62shbv5mxof65uohxh5piyexgk7wpedoel3@cq4zdknykwqc>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
 <e36c1a44096cbd7e9cb693f2300ac12ed1b2f79d.1710670958.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e36c1a44096cbd7e9cb693f2300ac12ed1b2f79d.1710670958.git.u.kleine-koenig@pengutronix.de>
X-ClientProxiedBy: FR5P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::13) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|BEZP281MB2915:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yVuLy7CPHojtHvjGGbN1T2KfEEgJSWdRX0doc1LHamWZ5Deze5JEYZSvmSU9yQjLPW1UQM7m67uY7Pp4bUU06b7+QbWCi+sd/Nmtf0i3lma3TW4/fhHCHWbhBdUluxtv3JedYIL7wWwsNI8Nm6SJ1VhKYoPENIycOQlp3EuRJRlWgLwv04N0dfG4N+R/VxO+ZB0T7WRDWIl2JHXhIirVdWfuXAxmsxozXiZ935jcHzxNJ8KmkyqVlncM9dd6WiHQOv+E/EO/Fk0uFHtpAwraTI3OuFsLlMQq0vj/X3GQsUBjaFBvQdEks/uRxP4wHSeTMYBtVAhF6mrBOj530lwUlY4qd/00M+bLz90NVwAZ4wuO1UQfGpCMUTZ9mfjxoF3Qpbsg6PkEYxrLrLc18hD+HG+Oeo2aTuyFUn9XEekuTi7H86Eg1k82l3G2gePRF8J6Y0dXw0Z8BBM/BcDuFi9k58TF1bkJkwsJvK7j3m1V1eRrvs6EU2jqPyV/ecSvzHpi0Iq/JL2Qnd/94qEp/qVNsNoXNh1oGH/P8cJlOhotHv0Ltgjj0lrqnmK5XNbhaNG7on8JJcD/NyRU9yk40IQbBtE0HYrq4yAVvoChZ3Rz9ZGYidErlGf0iboMIoDB0PoW07HHEtdjRLW+gNzU8Zx/YYd6nZoMRB2JEGastGg4eK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Jw5QUSQIL9MzxHS81i6os4WMlqxbv98IYIG0lqoEReei2rlxtowp9uFbyv?=
 =?iso-8859-1?Q?BknagXzMxbRXzro9xT9O9fpRe2S8Zx5bVAJGJnQzqvWdK2VpfZlqz/wS7Z?=
 =?iso-8859-1?Q?e9DdHMJkijzwNz17MChILrapoC99/HuZXnoFR2UDJs8/EaE+hkL8MUsq56?=
 =?iso-8859-1?Q?OIA5YA3PxgE2lqNab/sVeDPr2W7L1G8y5wY/g5eeIbKX9rDlvbPbufxflk?=
 =?iso-8859-1?Q?LnRQUiD7KwYsbI0XMbbDa6l4FdhTtDEvOC66RKYAqRw5+MqptEa9LF0MWE?=
 =?iso-8859-1?Q?+w3Kncvn81muYJ6KBhnIjXZrT4XDX1jdF6IsWYkeUiqPQJ1NvR7hzA9npu?=
 =?iso-8859-1?Q?2TZJd1eRE5DrWNKqLzYr2ZSfsKOYR0xyImztXxkB4es96l5bdl/gq1fJaF?=
 =?iso-8859-1?Q?E33xnBTDYqJGXU9djWMda5NHARYfxfe54kZ9bFb9qdN22yF3Qd7wEex7HO?=
 =?iso-8859-1?Q?ArRH7aKTZnq11OaW/pMQ/AJ66KAzHiIggPcFQg3gwdegN1ps23GXH4IZgm?=
 =?iso-8859-1?Q?fy7Fr+stcV8Ln7yIz4hTQ+xZtPt9mHxdKZLrVR/67ApbBOqs5jGottsUgn?=
 =?iso-8859-1?Q?knlztJbKZAD9e8lnnyVojIaYS1pzDNIrs7t58YOVMsBuaF1R3EBvruDLUx?=
 =?iso-8859-1?Q?ZqXDlXvdD7JweUsPKvlrDOhWiugXbJttt2DGnN3+swhxB0irWlPhLs/5zF?=
 =?iso-8859-1?Q?SeJWG2ttBEt9GKJlcDzT71DjmGaJH0/LbeWa52ACU8poac+4CeGuKkdSMy?=
 =?iso-8859-1?Q?dAezwx2NwQGAjPfq7eGJyVuenn95BVLmeJArCsAo0IF+0Zx47jvWCbaBny?=
 =?iso-8859-1?Q?aP6X8ZApperb0+NycJ6NaHvFcFdvjGDEvb8NPQZxoA+Qc1Fg6MJNOR2GKt?=
 =?iso-8859-1?Q?AT0GpQbkDmSuDnErd7d79Jgs05+CPdeaacpQ0WbWZaH1PCtrZXC2xLQp/z?=
 =?iso-8859-1?Q?6VWEY1TZFz+AR8KrlfAY5BeYFxcK7j9WJkTOB4+eAEJgJZ0+VT5gGoVHuT?=
 =?iso-8859-1?Q?ZFOtjZID4vwijK+3n/fac6wTER13xi7HOKsetxQUVGyvB7n2BfSSK9pIhE?=
 =?iso-8859-1?Q?WlvggUvS+WyiLBBIAhk3lvfRPdOE8oSi5eZ+jTH8Td9BJonxfUBZkKTc7c?=
 =?iso-8859-1?Q?E/VD0+Pgreec9sY4LT/AwuRo8NSAs3xX7gmr4EEy3gtWZXF8BOzuz/QeD9?=
 =?iso-8859-1?Q?5nw8YADYAEe9LdyXBJ3BtfdAAMxcPc4HwUPDecRzyRTakR1zohDhmnEwRU?=
 =?iso-8859-1?Q?01J0J4Wbi94MjJN8JbQmG7m2l01DpmI9aUq71qUzbGdNSgmZ9kiIc/T7FX?=
 =?iso-8859-1?Q?vmg3EVYctvhkNz2lhhxx7Jl82/WdvhfOP2fg6lkC6DBu5UA73OlGtnmQRS?=
 =?iso-8859-1?Q?9CgNsTWYtulzlqw5FAGIYfrouLyz+JNLKhLBrVwLdIiFvcNsmNBUXT7ga6?=
 =?iso-8859-1?Q?wV0bGxVKYwvQ64rqarLiVshnsCpW7oCZEAEYy0Wu+ZXShU2uAFBzSm4NPu?=
 =?iso-8859-1?Q?mMNGyJp/aAMhT03Pf2cRANkzq8v4Au1+kQnODdjrWWKBB2celNOS9dvrQJ?=
 =?iso-8859-1?Q?o8++98g15t+s70yCpcSmIXgni6yTribhZMU6fiTcje736mcG/0NuCjrhMP?=
 =?iso-8859-1?Q?Xu26sI33+BmjVP38z4d0/GZbFBjBmOI12MirGFx2elBC/A67EB5mOorVDs?=
 =?iso-8859-1?Q?K6HThZJZYuVtiyS5tEa3UTBIOjaPqwX50y/dyJaqPU5yN0uiuaC2XZ/VZN?=
 =?iso-8859-1?Q?NJUQ=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5a0a4b-3da0-47a6-0b17-08dc471d120c
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:28:56.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOmgOC5Du5I2NcW5SNj9YIEUNxLmjZfCUE982z706/cH1VrUixEUgLC9HOhPBRjH4XTOtuD8jVDLSJyfGilU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2915

Hello Uwe,

On Sun, Mar 17, 2024 at 11:40:38AM +0100, Uwe Kleine-K=F6nig wrote:
> This ensures that a pwm_chip that has no corresponding driver isn't used
> and that a driver doesn't go away while a callback is still running.
>=20
> In the presence of device links this isn't necessary yet (so this is no
> fix) but for pwm character device support this is needed.
>=20
> To not serialize all pwm_apply_state() calls, this introduces a per chip
> lock. An additional complication is that for atomic chips a mutex cannot
> be used (as pwm_apply_atomic() must not sleem) and a spinlock cannot be

Nitpick: s/sleem/sleep/

> held while calling an operation for a sleeping chip. So depending on the
> chip being atomic or not a spinlock or a mutex is used.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  | 98 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/pwm.h | 13 ++++++
>  2 files changed, 103 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 09ff6ef0b634..2e08fcfbe138 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -29,6 +29,22 @@ static DEFINE_MUTEX(pwm_lock);
> =20
>  static DEFINE_IDR(pwm_chips);
> =20
> +static void pwmchip_lock(struct pwm_chip *chip)
> +{
> +	if (chip->atomic)
> +		spin_lock(&chip->atomic_lock);
> +	else
> +		mutex_lock(&chip->nonatomic_lock);
> +}
> +
> +static void pwmchip_unlock(struct pwm_chip *chip)
> +{
> +	if (chip->atomic)
> +		spin_unlock(&chip->atomic_lock);
> +	else
> +		mutex_unlock(&chip->nonatomic_lock);
> +}
> +
>  static void pwm_apply_debug(struct pwm_device *pwm,
>  			    const struct pwm_state *state)
>  {
> @@ -183,6 +199,7 @@ static int __pwm_apply(struct pwm_device *pwm, const =
struct pwm_state *state)
>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state)
>  {
>  	int err;
> +	struct pwm_chip *chip =3D pwm->chip;
> =20
>  	/*
>  	 * Some lowlevel driver's implementations of .apply() make use of
> @@ -193,7 +210,13 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, co=
nst struct pwm_state *state)
>  	 */
>  	might_sleep();
> =20
> -	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
> +	pwmchip_lock(chip);
> +	if (!chip->operational) {
> +		pwmchip_unlock(chip);
> +		return -ENODEV;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
>  		/*
>  		 * Catch any drivers that have been marked as atomic but
>  		 * that will sleep anyway.
> @@ -205,6 +228,8 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, con=
st struct pwm_state *state)
>  		err =3D __pwm_apply(pwm, state);
>  	}
> =20
> +	pwmchip_unlock(chip);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
> @@ -291,16 +316,26 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
>  int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
>  		unsigned long timeout)
>  {
> +	struct pwm_chip *chip;
>  	int err;
> =20
> -	if (!pwm || !pwm->chip->ops)
> +	if (!pwm || !(chip =3D pwm->chip)->ops)
>  		return -EINVAL;
> =20
> -	if (!pwm->chip->ops->capture)
> +	if (!chip->ops->capture)
>  		return -ENOSYS;
> =20
>  	mutex_lock(&pwm_lock);
> -	err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
> +
> +	pwmchip_lock(chip);
> +
> +	if (chip->operational)
> +		err =3D chip->ops->capture(pwm->chip, pwm, result, timeout);
> +	else
> +		err =3D -ENODEV;
> +
> +	pwmchip_unlock(chip);
> +
>  	mutex_unlock(&pwm_lock);
> =20
>  	return err;
> @@ -340,6 +375,14 @@ static int pwm_device_request(struct pwm_device *pwm=
, const char *label)
>  	if (test_bit(PWMF_REQUESTED, &pwm->flags))
>  		return -EBUSY;
> =20
> +	/*
> +	 * This function is called while holding pwm_lock. As .operational only
> +	 * changes while holding this lock, checking it here without holding th=
e
> +	 * chip lock is fine.
> +	 */
> +	if (!chip->operational)
> +		return -ENODEV;
> +
>  	if (!try_module_get(chip->owner))
>  		return -ENODEV;
> =20
> @@ -368,7 +411,12 @@ static int pwm_device_request(struct pwm_device *pwm=
, const char *label)
>  		 */
>  		struct pwm_state state =3D { 0, };
> =20
> +		pwmchip_lock(chip);
> +
>  		err =3D ops->get_state(chip, pwm, &state);
> +
> +		pwmchip_unlock(chip);
> +
>  		trace_pwm_get(pwm, &state, err);
> =20
>  		if (!err)
> @@ -997,6 +1045,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent=
, unsigned int npwm, size_t
> =20
>  	chip->npwm =3D npwm;
>  	chip->uses_pwmchip_alloc =3D true;
> +	chip->operational =3D false;
> =20
>  	pwmchip_dev =3D &chip->dev;
>  	device_initialize(pwmchip_dev);
> @@ -1102,6 +1151,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct mo=
dule *owner)
> =20
>  	chip->owner =3D owner;
> =20
> +	if (chip->atomic)
> +		spin_lock_init(&chip->atomic_lock);
> +	else
> +		mutex_init(&chip->nonatomic_lock);
> +
>  	mutex_lock(&pwm_lock);
> =20
>  	ret =3D idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
> @@ -1115,6 +1169,10 @@ int __pwmchip_add(struct pwm_chip *chip, struct mo=
dule *owner)
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_add(chip);
> =20
> +	pwmchip_lock(chip);
> +	chip->operational =3D true;
> +	pwmchip_unlock(chip);
> +
>  	ret =3D device_add(&chip->dev);
>  	if (ret)
>  		goto err_device_add;
> @@ -1124,6 +1182,10 @@ int __pwmchip_add(struct pwm_chip *chip, struct mo=
dule *owner)
>  	return 0;
> =20
>  err_device_add:
> +	pwmchip_lock(chip);
> +	chip->operational =3D false;
> +	pwmchip_unlock(chip);
> +
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_remove(chip);
> =20
> @@ -1145,12 +1207,27 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
>  void pwmchip_remove(struct pwm_chip *chip)
>  {
>  	pwmchip_sysfs_unexport(chip);
> +	unsigned int i;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	pwmchip_lock(chip);
> +	chip->operational =3D false;
> +	pwmchip_unlock(chip);
> +
> +	for (i =3D 0; i < chip->npwm; ++i) {
> +		struct pwm_device *pwm =3D &chip->pwms[i];
> +
> +		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +			dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);
> +			if (pwm->chip->ops->free)
> +				pwm->chip->ops->free(pwm->chip, pwm);
> +		}
> +	}
> =20
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_remove(chip);
> =20
> -	mutex_lock(&pwm_lock);
> -
>  	idr_remove(&pwm_chips, chip->id);
> =20
>  	mutex_unlock(&pwm_lock);
> @@ -1532,12 +1609,17 @@ void pwm_put(struct pwm_device *pwm)
> =20
>  	mutex_lock(&pwm_lock);
> =20
> -	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +	/*
> +	 * If the chip isn't operational, PWMF_REQUESTED was already cleared. S=
o
> +	 * don't warn in this case. This can only happen if a consumer called
> +	 * pwm_put() twice.
> +	 */
> +	if (chip->operational && !test_and_clear_bit(PWMF_REQUESTED, &pwm->flag=
s)) {
>  		pr_warn("PWM device already freed\n");
>  		goto out;
>  	}
> =20
> -	if (chip->ops->free)
> +	if (chip->operational && chip->ops->free)
>  		pwm->chip->ops->free(pwm->chip, pwm);
> =20
>  	pwm->label =3D NULL;
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 60b92c2c75ef..9c84e0ba81a4 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -274,6 +274,9 @@ struct pwm_ops {
>   * @of_xlate: request a PWM device given a device tree PWM specifier
>   * @atomic: can the driver's ->apply() be called in atomic context
>   * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate th=
is chip
> + * @operational: signals if the chip can be used (or is already deregist=
ered)
> + * @nonatomic_lock: mutex for nonatomic chips
> + * @atomic_lock: mutex for atomic chips
>   * @pwms: array of PWM devices allocated by the framework
>   */
>  struct pwm_chip {
> @@ -289,6 +292,16 @@ struct pwm_chip {
> =20
>  	/* only used internally by the PWM framework */
>  	bool uses_pwmchip_alloc;
> +	bool operational;
> +	union {
> +		/*
> +		 * depending on the chip being atomic or not either the mutex or
> +		 * the spinlock is used. It protects .operational and
> +		 * synchronizes calls to the .ops->apply and .ops->get_state()
> +		 */
> +		struct mutex nonatomic_lock;
> +		struct spinlock atomic_lock;
> +	};
>  	struct pwm_device pwms[] __counted_by(npwm);
>  };
> =20
> --=20
> 2.43.0
>=20
>=20

Best regards
Thorsten

