Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7732E0D68
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgLVQdY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 22 Dec 2020 11:33:24 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:40302 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgLVQdX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 11:33:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id AC5112415A;
        Tue, 22 Dec 2020 16:32:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 01he_5yAQHXN; Tue, 22 Dec 2020 16:32:42 +0000 (UTC)
Received: from jupiter (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 8EF1F24157;
        Tue, 22 Dec 2020 16:32:29 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-rockchip@lists.infradead.org, thierry.reding@gmail.com,
        tpiepho@gmail.com, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] pwm: rockchip: Do not start PWMs not already
 running
References: <cover.1608407584.git.simon@simonsouth.net>
        <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
        <20201221090553.bopd2aaoheapww3r@pengutronix.de>
Date:   Tue, 22 Dec 2020 11:32:29 -0500
In-Reply-To: <20201221090553.bopd2aaoheapww3r@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 21 Dec 2020 10:05:53
 +0100")
Message-ID: <871rfhreci.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> "starting PWM" here means enabling their clocks, right? I wouldn't
> expect that this has any effect on the output, am I right?

Right, it does not; another misunderstanding on my part. I'll fix the
commit message.

> Just for my understanding: That you moved clk_prepare_enable(pc->pclk)
> further down is not strictly necessary for your change, right?

That's right. My thought was to keep the code that enables this clock
close to the code that relies on it, and to minimize the duration the
clock is enabled.

Would it be better to leave the code where it is?

> I'm not a big fan of this ?: construct...

Neither was I, actually, but I guessed the shorter version would be
preferred. I'm happy to change it back to match what you described.

-- 
Simon South
simon@simonsouth.net
