Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890B7013B2
	for <lists+linux-pwm@lfdr.de>; Sat, 13 May 2023 03:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbjEMBMz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 May 2023 21:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjEMBMy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2023 21:12:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A575B8A;
        Fri, 12 May 2023 18:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJdR0sPt3KPj/IjaV56FGbD3q5fAda9BigeRQ117mPukYvCeH0TZ2aSHJCylZblFgaMP2jUg3oiCd0kDROB5dwwPE8AzFxaGTCreP84A5EHnvfd8xiE78X4/g3xYzkWp60l4nLqUASsniCLpztv0fc3dTkxc6fSUvwUoyZzaocm9uQ8Cnvggd0NFkgIvxY9SBSOrUqH4EHVJt8NDj/dz0HxJNnwv88vAgNXkMhP/2ZOKX2LKi2U3TGChe/JPfI0H7Um5EKIkLq8bRk4nXj/nDZhy0+NzP8UWWMUtyIkLAG6/cL+M6caXSTB6lpcy8ASzHtFZqzRkW+btb5z4ip4eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+GHTG4Lro1Tgu40x4Kn/xOhjObog028NQxy90TwA+0=;
 b=hiZHdowxPVGyoINy5LeICeOmqvOIxnXrC8Z7BMVksVKfeIM1guCvBF+RvLodN1nyE8viyvJVfuRuQq8Ki0WUJa3Q9LEH2S926HVaOXk0zPBZUM2RKI+63lQ0HEoc3dQNqqheTBmw3HqYP88+ML95yivmmt6wcfoBRQh1TlgEPGdBNyc2Sww85i/uy6sRaYIZYIjlS66uVEUA4o0Ve5eUR2F/SuWAjr35zjyjbU1hMaUpWlrzXeGV+nmlpkDx/jCIuoZ2EutjdV7dM+XSOTDKQilP9buhXNuc2uY+KHsfklK7mRedv3rSQYcRkXfJ5rayQ1P4dGWTDIvt4VtVIXiZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+GHTG4Lro1Tgu40x4Kn/xOhjObog028NQxy90TwA+0=;
 b=FDlRuMS45rdRny24cTp6DEgnCFAMjJifpgsOmUAgTk4WdxPP0goTvfC1BjHw/4eeF4h3Xy9wDnnFVzzlqKaLt4+BIeT6A6gd05hFIx4VaiTG/d7CwTzLEFERH1AccndrZqj2YfXuAB8GJ6ND/2AjiYb7X/shGHruwXCQVZfHbvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA3PR08MB8873.namprd08.prod.outlook.com
 (2603:10b6:806:382::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 01:12:49 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.032; Sat, 13 May 2023
 01:12:49 +0000
Date:   Fri, 12 May 2023 20:12:42 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <ZF7kCjKGVjsxK8ec@nixie71>
References: <20230512185551.183049-1-marex@denx.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512185551.183049-1-marex@denx.de>
X-ClientProxiedBy: SA0PR11CA0160.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::15) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA3PR08MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c7ee72-6f79-427c-f5c9-08db534f2ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVsrrFe5l6TEeYhbrUl7RL8sbMMury8G2knpPoW0Z85gYUOyCzpBJj4QAck9cJyKI5yU+f51owh86jXONb6Ce8L9LgFPWvF75fOmtSuR6kpzrT2uiXgxvx80JJruk+VqjTYBwY3L1wP8DYaZHX0qL92sniDXoGILgKkXh77kH5diSXHnZ2qkLN12MpngbccV3lYFZLK6iPqFyVO7YgPzZyMSnS5NH3ELv4Qatji5nJmM4HDA+JPCUk09/GvPvq12/pEceFrwB2nPj1Y7FNnshmJfzSSiZ8dpdSBBJCwETaFDwWfNtNtQZV6XmKbITiYMAlWU3lRiW9S10obei50oLXfgStIH+ZhUKDqXwhaIQreE31YUmd+KYQhqLlk/HtOPiECev9S6lvo67iQksgy2WXAlthwNgHoyCqtaSm2R3ViLiWqZob0Sjywgi7pKOU4VWp8JxjIdkpoSkW59hUjwp4VDN65jNVWOA+6RhhW5k5spbfi1RDB58Co9aqs1VLw9fj7Zvfs//WSeP2ffEWUOxx4mg1N/C93ZfzDEZZrYZeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39830400003)(376002)(136003)(346002)(366004)(451199021)(83380400001)(66899021)(66574015)(54906003)(8676002)(8936002)(478600001)(316002)(66946007)(66556008)(4326008)(66476007)(5660300002)(86362001)(2906002)(33716001)(966005)(38100700002)(41300700001)(6486002)(26005)(9686003)(186003)(6512007)(6506007)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PEMHB2OB3Hi+0qMhO0T4wmv1TV61ZMBQ5VImwL6BX1TYad4uWzifVhVr4a?=
 =?iso-8859-1?Q?Ex5leSyQSTTG4lNXM+sWa+NV4w/TR3ILviiAnmHKlh7p0f1MIUOdrJthw9?=
 =?iso-8859-1?Q?UPrfFdO8ljtX8ANxfmGEHknxOAIAE6reD4Z9k2tOkalpYHtRRgHYEquTye?=
 =?iso-8859-1?Q?Yk8RYMj17HpiEXxCukgWrmgxnkE64GoV7CUlm4FXSlSgUiF12DPCPuaqSV?=
 =?iso-8859-1?Q?keOSYxNLlQq0BZylTBeQR4QYeFXv+vtGvTdFXTmK/JtoRV6hsHirG89wD2?=
 =?iso-8859-1?Q?FFF8nyHyRRMZyr/os39pwREa/cNMEkTfzBaE0tshgRcGNXw+fSvmXGimcM?=
 =?iso-8859-1?Q?pUmWsRd0O5Jf7YUqZURX2/Ja9EotsYZvhOW/0DebuuMssCAjtOrjXCDmCP?=
 =?iso-8859-1?Q?fkDkk2pi2ogtTNx8z0QphtaKwGDq/Lm4mmIkLqlU//z1b+Ghdw3OVBLYMZ?=
 =?iso-8859-1?Q?hA185rhBQjKOJdsGDLA6CfLT8x1bcQ7+N6heoAeexVP7Ch3JQ+W4vTs9lT?=
 =?iso-8859-1?Q?V+YtnGW/KPdBaYzzoyURmJCQQxFJv5DmKPi+FMWBvYyFi65N5Dq1g10meK?=
 =?iso-8859-1?Q?4iEUOKpzQmNxZGq9ywSDOBb0uWabkhy02h0c00jLtsBi78b7Y15cQYnaXh?=
 =?iso-8859-1?Q?UT36m8r7kDRyR+RtFdRqx5251/dOxJAvXCGSAWjHby4Gav3Q9r+SM9JGSv?=
 =?iso-8859-1?Q?RpOEOIW0j5G6TI117W8X2p4UXQKrfXGINh5KurAYvW5J4YulefYQo0xiYW?=
 =?iso-8859-1?Q?fuRTVtVNXBjn+pMiIP1JfCQGZXywMgL2q1eJvadAWdgBu7Q2dRJLRkbklq?=
 =?iso-8859-1?Q?Zc92/PDR5hySH2c9i3Agn1VeqK6Mmt8ik0TbSyaKBtqyVuHnuQj69nj6Rv?=
 =?iso-8859-1?Q?kUeN5eRExe96tj/5ETDVhGildio3AcC9MWEVuh6as2DLzxqseYtIjah7+7?=
 =?iso-8859-1?Q?5cGwtmoQOGiJottWoWdETpF94tpkur51I4YbiOqLMY2CpaRGA8v82tdioE?=
 =?iso-8859-1?Q?MTAEH7c/gdOd4vUkztCV9E+a2p+seWBdb1dqqZC4qGSF0i2epw503EIdOJ?=
 =?iso-8859-1?Q?YF0UV9yFgzbdBGrzMWB+7M5lgkr/vY0ndzdVolU3gDiMJ360t78suaIjZz?=
 =?iso-8859-1?Q?XGAqg/cKvTsCOAPKw95ysfmV+po3EWVoznEpYkUErP0KjoKk6KG2qn3Njc?=
 =?iso-8859-1?Q?6sebt4rfzN95tCeAqfTz+MXUH28YPgGlZipQUS3aEZRR02nxDThqgqymrK?=
 =?iso-8859-1?Q?yP1VXpK1m8bQBH4xVTPX8VSN5gC8c2yb6W+k3HbIEfvld7OtRj2iVH0xhr?=
 =?iso-8859-1?Q?XGHdj9Myny2hTLRIdfGqCZKag8Z16ZoCQxKlQUn4e0IQFLLVKEBboazgLM?=
 =?iso-8859-1?Q?n+vPpRjQA8UEY+zpm/Kat1r5JcGMdNr5YR/HnoBKPGO0bb9JjMLfw9SBt5?=
 =?iso-8859-1?Q?yEL9O8qkkmahDKALvBfRlDju9ljaUFB6l4fomVnGtGmC1t32Mfm5wlMfEL?=
 =?iso-8859-1?Q?xoX2CAXmmSsyTj/9othZAM0MbGpB9M7YBaElXHDhs2SFtT7yn+X6iaUj+H?=
 =?iso-8859-1?Q?rBDcGpds+/w52f6NqKh95YAZehRjFThawcylg5gGml7I/NwafXN0yMLsDm?=
 =?iso-8859-1?Q?46BPTITZ8yNf0vjYFLrVLpyOf3cFBppYt5?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c7ee72-6f79-427c-f5c9-08db534f2ae3
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 01:12:49.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiN0fu781XaeVnlaEDodKX6HNkKrVQZKjKLNnWuqBAGcYdkYuswz67TBKbhU32TwNSv/CDTKjz0llsCB8E7WUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR08MB8873
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Marek,

On Fri, May 12, 2023 at 08:55:51PM +0200, Marek Vasut wrote:
> The PWM beeper volume can be controlled by adjusting the PWM duty cycle,
> expose volume setting via sysfs, so users can make the beeper quieter.
> This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0
> to 50% in 1/1000th of percent steps, this resolution should be sufficient.
> 
> The reason for 50000 cap on volume or PWM duty cycle is because duty cycle
> above 50% again reduces the loudness, the PWM wave form is inverted wave
> form of the one for duty cycle below 50% and the beeper gets quieter the
> closer the setting is to 100% . Hence, 50% cap where the wave form yields
> the loudest result.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> An alternative option would be to extend the userspace input ABI, e.g. by
> using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and
> bottom 16bit to encode the existing frequency in Hz . Since frequency in
> Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits
> just fine. Thoughts ?
> ---

Thanks for the patch; this seems like a useful feature.

My first thought is that 50000 seems like an oddly specific limit to impose
upon user space. Ideally, user space need not even care that the beeper is
implemented via PWM and why 50000 is significant.

Instead, what about accepting 0..255 as the LED subsystem does for brightness,
then map these values to 0..50000 internally? In fact, the leds-pwm driver
does something similar.

I'm also curious as to whether this function should be a rogue sysfs control
limited to this driver, or a generic operation in input. For example, input
already allows user space to specify the magnitude of an FF effect; perhaps
something similar is warranted here?

> NOTE: This uses approach similar to [1], except it is much simpler.
>       [1] https://patchwork.kernel.org/project/linux-input/cover/20230201152128.614439-1-manuel.traut@mt.com/
> ---
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> Cc: Manuel Traut <manuel.traut@mt.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> ---
>  drivers/input/misc/pwm-beeper.c | 58 ++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index 3cf1812384e6a..f63d0ebbaf573 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -21,6 +21,7 @@ struct pwm_beeper {
>  	struct regulator *amplifier;
>  	struct work_struct work;
>  	unsigned long period;
> +	unsigned long duty_cycle;
>  	unsigned int bell_frequency;
>  	bool suspended;
>  	bool amplifier_on;
> @@ -37,7 +38,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
>  
>  	state.enabled = true;
>  	state.period = period;
> -	pwm_set_relative_duty_cycle(&state, 50, 100);
> +	pwm_set_relative_duty_cycle(&state, beeper->duty_cycle, 100000);
>  
>  	error = pwm_apply_state(beeper->pwm, &state);
>  	if (error)
> @@ -119,6 +120,53 @@ static void pwm_beeper_close(struct input_dev *input)
>  	pwm_beeper_stop(beeper);
>  }
>  
> +static ssize_t volume_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%ld\n", beeper->duty_cycle);
> +}
> +
> +static ssize_t volume_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Volume is really PWM duty cycle in pcm (per cent mille, 1/1000th
> +	 * of percent). This value therefore ranges from 0 to 50000 . Duty
> +	 * cycle of 50% = 50000pcm is the maximum volume .
> +	 */
> +	val = clamp(val, 0UL, 50000UL);
> +	/* No change in current settings, do nothing. */
> +	if (val == beeper->duty_cycle)
> +		return count;
> +
> +	/* Update current settings and apply to PWM chip. */
> +	beeper->duty_cycle = val;
> +	if (!beeper->suspended)
> +		schedule_work(&beeper->work);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(volume);
> +
> +static struct attribute *pwm_beeper_dev_attrs[] = {
> +	&dev_attr_volume.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pwm_beeper_attr_group = {
> +	.attrs = pwm_beeper_dev_attrs,
> +};
> +
>  static int pwm_beeper_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -192,6 +240,14 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  
>  	input_set_drvdata(beeper->input, beeper);
>  
> +	beeper->duty_cycle = 50000;
> +	error = devm_device_add_group(dev, &pwm_beeper_attr_group);
> +	if (error) {
> +		dev_err(dev, "Unable to create sysfs attributes: %d\n",
> +			error);
> +		return error;
> +	}
> +
>  	error = input_register_device(beeper->input);
>  	if (error) {
>  		dev_err(dev, "Failed to register input device: %d\n", error);
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy
