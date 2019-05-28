Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2A2BCAA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2019 03:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE1BKm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 21:10:42 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:27853 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfE1BKm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 21:10:42 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4S1AeVo073086;
        Tue, 28 May 2019 10:10:40 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 28 May 2019 10:10:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.225] (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4S1AdV8073075
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 28 May 2019 10:10:40 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Subject: Re: [PATCH v5] pwm: renesas-tpu: Add suspend/resume function
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au,
        geert+renesas@glider.be, broonie@kernel.org,
        linux-pwm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com,
        kuninori.morimoto.gx@renesas.com, h-inayoshi@jinso.co.jp,
        na-hoan@jinso.co.jp
References: <1558923757-9843-1-git-send-email-cv-dong@jinso.co.jp>
 <20190527141741.GC7202@ulmo>
From:   Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <bbc7a187-d1ad-2ba5-0ee1-e241461faca5@jinso.co.jp>
Date:   Tue, 28 May 2019 10:10:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527141741.GC7202@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dear Thierry-san,

Thank for your feedback!

> This has been discussed before, but this really shouldn't be done in the
> PWM driver. Consumers should really be reconfiguring the PWM upon resume
> as appropriate. This is the only way to ensure that everything is
> resumed in the proper order.
>
> Most, if not all, consumers already implement suspend/resume that way.
> sysfs is the only one that I'm aware of that doesn't.
>
> Since you've been using sysfs to test this, things are slightly more
> complicated (i.e. we don't have a consumer driver in the conventional
> way). However, you should be able to solve this by implementing
> dev_pm_ops for the pwm_class.
>
> Do you think you could give that a try?

I understood the problem. Really this is difficult with me.
Therefore, I will just stop here.

Thank you,
Dong

> Thierry
>
