Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC589CF6B4
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfJHKCN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 06:02:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37235 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbfJHKCN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 06:02:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so16866120lje.4
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2019 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GqzTqyowvPAvUQbXgGnvR7I0v85sKzoqVofmPdE4wrQ=;
        b=Wq+k9y3cqefVkZ1tL1Y6xqcaD3CqIz8/tHswdPC7vEhgEGm1vMawqMRWqG0DJywGT4
         8fmOpR2baz2OYprCPC1aEY2/tk0YjGKyKnNmrKJqXnyYPhOuLyW9yuN/Nl6uxfwS4oBi
         k7PN8yNJCpnN5dt7uymncpWz1kmBiGAfGidf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GqzTqyowvPAvUQbXgGnvR7I0v85sKzoqVofmPdE4wrQ=;
        b=mJ+l01U05Et6vVCH80FGpVlA7w/rWasPcVVV0ybkBIj87NvAWCLNCNYEfo6w5FfmWh
         iB30PpjEezfLqbQtXzcn9QQTf4RRekeiwCp3wZ98DDVZ3pnyp32dDlRJ5HfIxD37lJuN
         9FtZPDE4AhBtmbxdPP9ZeQ4pwoMOW9IU2sOBBYGHkAiqSX7ou5J0gh/6ubmTy9HDakfa
         sQCl/4+lCrV/jTFoHgk7+ThfrbpP7YFEEdzDQQMQuwqE1GICOPMOWGQCvrcVN9ngdjfe
         00jU3+OEsf/Lf/XvLFfQdL5B5TvJJyu1IUM653qOo6MMmc6l5l2cxog66FWCe0ys5DVR
         ITcQ==
X-Gm-Message-State: APjAAAXJxTLJ0MlFGHuvZlsByNEv4xVIgoFPgfN88M8fZDQLuqFJFuth
        F78at227rKiE8AdCtzfVeJgj2w==
X-Google-Smtp-Source: APXvYqwvUV0ApYMZHzivst3YYWRXTTQ6OC4spgiYQAFuQFqWZDioKWemwjZ7KV+AIcEc9czHUR3KkQ==
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr15734325ljc.210.1570528929703;
        Tue, 08 Oct 2019 03:02:09 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f21sm4366420lfm.90.2019.10.08.03.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:02:09 -0700 (PDT)
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
 <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
 <20191008093145.kgx6ytkbycmmkist@holly.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
Date:   Tue, 8 Oct 2019 12:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008093145.kgx6ytkbycmmkist@holly.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/10/2019 11.31, Daniel Thompson wrote:
> On Mon, Oct 07, 2019 at 08:43:31PM +0200, Rasmus Villemoes wrote:
>> On 07/10/2019 17.28, Daniel Thompson wrote:
>>> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
>>>
>>> It feels like there is some rationale missing in the description here.
>>>
>>
>> Apart from the function call overhead (and resulting register pressure
>> etc.), using int_pow is less efficient (for an exponent of 3, it ends up
>> doing four 64x64 multiplications instead of just two). But feel free to
>> drop it, I'm not going to pursue it further - it just seemed like a
>> sensible thing to do while I was optimizing the code anyway.
>>
>> [At the time I wrote the patch, this was also the only user of int_pow
>> in the tree, so it also allowed removing int_pow altogether.]
> 
> To be honest the change is fine but the patch description doesn't make
> sense if the only current purpose of the patch is as a optimization.

Agreed. Do you want me to resend the series with patch 3 updated to read

"For a fixed small exponent of 3, it is more efficient to simply use two
explicit multiplications rather than calling the int_pow() library
function: Aside from the function call overhead, its implementation
using repeated squaring means it ends up doing four 64x64 multiplications."

(and obviously patch 5 dropped)?

Rasmus
