Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91122BDB3
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgGXFtF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 01:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGXFtF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 01:49:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A7C0619D3;
        Thu, 23 Jul 2020 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mAPXl0NDLYdboIS99KrSvjMPA4nK0CxRAyEDoQIHXRg=; b=d5NkrHs4LOt8suSOTjBaEYL2ZI
        9JvFprR4s7ssZ3zc306RhWmhvlxQ5u88avs2HyVKs7DDvQOaGQNGnukVYxvpTwg3wKHWNjI3Vuf2S
        JdJaCy3MMvtDWCOOL+DkvM3l0eOIC8nCpkuQvjS5dvbRQCCIs6iI7ZjajLp0XqjQkwR8PdptG7EZs
        3zD8Vb6pBds2TGkeePrnESl4uxKxKKbuzKPCJ2f5hby20dGCIpWGRU8kNmO0WqDqwwvysfz1YdnNj
        HtPurnZjKZSs+womckcatFRC6fVF5/Dlcj84X+xtbao0K5muCfoFPP8/hrPPALUjfXM3PcLN2+ky4
        qG7c3DUg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyqZh-0000Ad-M9; Fri, 24 Jul 2020 05:48:57 +0000
Subject: Re: [PATCH V17 3/3] Input: new da7280 haptic driver
To:     Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
 <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
 <DB8PR10MB343644A6DADE61D62BEE157C85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
 <f549102d-4e69-c903-1672-f50bdb7994a3@infradead.org>
 <DB8PR10MB343624BF003338E8B34439AC85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0f604bb1-f8b8-b262-c8ae-b346755b99f1@infradead.org>
Date:   Thu, 23 Jul 2020 22:48:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DB8PR10MB343624BF003338E8B34439AC85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/23/20 10:47 PM, Roy Im wrote:

> OK, thanks for your comments. To be clearer, I would like to update as below if you agree
> 	
> 	depends on INPUT && I2C
> ...
> 	The haptics can be controlled by PWM or GPIO
> 	with I2C communication.

Yes, that sounds good. Thanks.

-- 
~Randy

