Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB6190767
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2020 09:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCXIQF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Mar 2020 04:16:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35794 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgCXIQF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Mar 2020 04:16:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so2403975wmi.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Mar 2020 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nCmrtRi63VazCm5/zsbCw7DEK5Z7dLbwQao7Tq0w8UI=;
        b=TYxi9wxqyr7ZuG8v7NeMKLzIJ5DKBo0KD25LlPVXxOMPs9byUNhx5xErNOM2TNuu4W
         uBQ5djcQQUevw22VSpRPc+SGlWLzzM3AHp1SwUhrvqAOIhayuejqPjAmtJP7agqPd6TX
         7/A5dhfR3w1WC3TWWDv/dQ+y2AT4kyf6qBWOnSNmY0LDL8p2FCUI+v3XQIIgF+P0Gjo9
         ZVRykXOxoW2DEfM77oSzjwjeNrqKvnGsSqmbQCDnBQEI2lziwn2q89CgYC56yEf7YG90
         CbgVL68NrZX32+c59WxzYUknlxv/eGId9maiUFN2jENO3yLPZlOWOY7eLLTIoqpCuS0g
         BWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nCmrtRi63VazCm5/zsbCw7DEK5Z7dLbwQao7Tq0w8UI=;
        b=c+VHbNSk3FP40b55ff+97cvo9NlaLt66+vZbdzdk03PXL1lNUBiB0ZYl+LAxDOBAmj
         1EnZvJwH7r3Dg8aRNbYiR66Bq5o5zJxgyUgXGJl0/Caq5bW6zQ2HpLdVsJk/813MdE3y
         0+XMIwa9xynLkE2Z5zvc1s3zC6cWIokiplsoLm8rIiaEtAqInmceZnCg6AyiRwDRq/pd
         MmfIiT7Fh/K1QYf1UuNfQ/A5QN2osefNLPV6Hi6WvR2r/HNwLSRlY4VynxvIk7ApQXOX
         YwCi49RlzsFXuBEvLgTnI19msI462QJHde6z/p5AlFsP+mByM8Hs5WDo4fuOglvFpJat
         GCOg==
X-Gm-Message-State: ANhLgQ2x9Zsr6g7CCiKpuqXYalK/FV2KuO6reyJHajblksf75r5RiB9N
        0JBfxqPJOgD3kzYosmi5tC1Bqg==
X-Google-Smtp-Source: ADFU+vu2MY3Q/scatxmu05MiPn0AajbEO2ZWaYCbPYz5dU4kEJeQFhYcQWrbv+Zv6zDqL1jyIuSs7w==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr3900004wmf.157.1585037762724;
        Tue, 24 Mar 2020 01:16:02 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id n124sm3337129wma.11.2020.03.24.01.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 01:16:01 -0700 (PDT)
Date:   Tue, 24 Mar 2020 08:16:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200324081651.GG5477@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
 <20200302141117.GA11787@labundy.com>
 <20200302142405.GA3494@dell>
 <20200323021605.GA2731@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323021605.GA2731@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 22 Mar 2020, Jeff LaBundy wrote:

> Hi Lee,
> 
> On Mon, Mar 02, 2020 at 02:24:05PM +0000, Lee Jones wrote:
> > On Mon, 02 Mar 2020, Jeff LaBundy wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> > > > On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > 
> > > > > > Well done Jeff.  Good job.
> > > > > > 
> > > > > > Applied, thanks.
> > > > > > 
> > > > > 
> > > > > Thank you for your kind words as well as your support in fleshing out this
> > > > > series.
> > > > > 
> > > > > Just to confirm, does your offer to take the remainder (once everything is
> > > > > approved) through immutable branches still stand?
> > > > 
> > > > Depends how quickly you can get the other drivers turned around.
> > > 
> > > With Uwe's approval from Friday, all five drivers are complete. Dmitry and
> > > Jonathan's approvals were given in previous review cycles and were carried
> > > forward with their permission. If anything else is required, please let me
> > > know.
> > 
> > Does Uwe's review mean that Thierry's is not required?
> 
> Sorry about that; I was jumping the gun (thank you Uwe for clarifying).
> The pwm patch still needs an Ack from Thierry before it can be applied.
> 
> I have not received any feedback from Thierry throughout this patch set,
> and I'd like to unblock the remainder if possible. In case Thierry does
> not respond by the time you elect to send your next pull request, would
> you be willing to drop the pwm patch and take the input and iio patches
> through your tree?
> 
> If so, I'll re-send the pwm patch on its own to Thierry during a future
> cycle so that he can take it through his tree at his convenience.

Hopefully we hear fro Thierry.

If not, yes I can apply the set without the PWM patch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
