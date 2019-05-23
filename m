Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1027560
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2019 07:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfEWFTJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 May 2019 01:19:09 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:35550 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfEWFTI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 May 2019 01:19:08 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4N5J6wA010165;
        Thu, 23 May 2019 14:19:06 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Thu, 23 May 2019 14:19:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.225] (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4N5J68X010152
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 23 May 2019 14:19:06 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Subject: Re: [PATCH v2] pwm: renesas-tpu: Add suspend/resume function
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        broonie@kernel.org, linux-pwm@vger.kernel.org,
        yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp,
        na-hoan@jinso.co.jp
References: <1558575210-28112-1-git-send-email-cv-dong@jinso.co.jp>
 <878suyuejo.wl-kuninori.morimoto.gx@renesas.com>
 <519f8d16-da5e-1904-ec02-ce9331f2b223@jinso.co.jp>
 <877eahvncc.wl-kuninori.morimoto.gx@renesas.com>
From:   Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <810fe28e-366e-5c96-e684-6cc46c3a2270@jinso.co.jp>
Date:   Thu, 23 May 2019 14:19:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877eahvncc.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dear Morimoto-san,

Thank for your feedback!

On 2019/05/23 13:07, Kuninori Morimoto wrote:
> Hi
>
>>>> +static int tpu_pwm_suspend(struct device *dev)
>>>> +{
>>>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>>>> +	struct pwm_chip *chip = &tpu->chip;
>>>> +	struct pwm_device *pwm;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i <= 3; i++) {
>>>> +		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
>>>> +			pwm = &chip->pwms[i];
>>>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>>>> +				return 0;
>>>> +		}
>>>> +	}
>>> why 3 ?
>> According to Hardware manual, 16-Bit Timer Pulse Unit (TPU)
>> supports four 16-bit timers for both R-car GEN2 and GEN3.
> Hmm...
> You need to use chip->npwm or TPU_CHANNEL_MAX then ?

Thank for your opinion!
I will resubmit v3 to change 3 to TPU_CHANNEL_MAX.

>>>> +	pm_runtime_put(dev);
>>>> +
>>>> +	return 0;
>>>> +}
>>> Do we need to call pm_runtime_xxx here ?
>> "pm_runtime_put(dev);" function is called for runtime idle operations.
> I know.
> I'm asking do we need to call it here ?

I think we should have it here better.

Thank you,
Dong

> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
