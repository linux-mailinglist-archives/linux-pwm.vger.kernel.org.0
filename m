Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7F2ACE2
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 04:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfE0CGp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 May 2019 22:06:45 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:36530 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfE0CGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 May 2019 22:06:45 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4R26fFW012596;
        Mon, 27 May 2019 11:06:41 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Mon, 27 May 2019 11:06:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.225] (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4R26euP012592
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 27 May 2019 11:06:41 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Subject: Re: [PATCH v4] pwm: renesas-tpu: Add suspend/resume function
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        broonie@kernel.org, linux-pwm@vger.kernel.org,
        yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp,
        na-hoan@jinso.co.jp
References: <1558917399-7065-1-git-send-email-cv-dong@jinso.co.jp>
 <875zpwu2hz.wl-kuninori.morimoto.gx@renesas.com>
From:   Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <2cc62ae3-f378-f67b-ce78-d17a82248312@jinso.co.jp>
Date:   Mon, 27 May 2019 11:06:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zpwu2hz.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dear Morimoto-san,

Thank for your feedback!

On 2019/05/27 10:24, Kuninori Morimoto wrote:
> Hi
>
>> This patch adds suspend/resume function support for Renesas the 16-Bit Timer
>> Pulse Unit (TPU) driver. This has been tested on the Salvator-XS board
>> with R-Car M3-N and H3 at renesas-drivers-2019-05-21-v5.2-rc1 tag.
>> I expect this to work on other SoCs.
> (snip)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int tpu_pwm_suspend(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
>> +		pwm = &chip->pwms[i];
>> +		if (pwm_is_enabled(pwm)) {
>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +				return 0;
>> +			tpu_pwm_disable(pwm->chip,pwm);
>> +		}
>> +	}
> I'm not familiar with pwm driver, but pwm_is_enabled() and
> if (!test_bit(PWMF_REQUESTED, &pwm->flags)) can be happen in the same time ?
> In other words, can we enable pwm without PWMF_REQUESTED ?

Thank for your help!
Can. Perhaps the PWMF_REQUESTED check is not necessary. I will remove it.

>> +static int tpu_pwm_resume(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
>> +		pwm = &chip->pwms[i];
>> +		if (pwm_is_enabled(pwm)) {
>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +				return 0;
>> +			tpu_pwm_enable(pwm->chip,pwm);
>> +		}
>> +	}
> Please use ${LINUX}/scripts/checkpatch.pl

Thanks for the prompt!

Thank you,
Dong

> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
