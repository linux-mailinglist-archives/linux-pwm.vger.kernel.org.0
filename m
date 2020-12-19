Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4066A2DF190
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Dec 2020 21:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgLSUdA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 19 Dec 2020 15:33:00 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:44772 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgLSUdA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 19 Dec 2020 15:33:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 33568C295C;
        Sat, 19 Dec 2020 20:32:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tEBBVf50JcDw; Sat, 19 Dec 2020 20:32:18 +0000 (UTC)
Received: from jupiter (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 46553C2902;
        Sat, 19 Dec 2020 20:32:06 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     tpiepho@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] pwm: rockchip: Eliminate potential race condition when
 probing
References: <875z5nof46.fsf@simonsouth.net>
        <20201130004419.1714-1-simon@simonsouth.net> <X9JfbpTnfqUVk6iN@ulmo>
Date:   Sat, 19 Dec 2020 15:32:06 -0500
In-Reply-To: <X9JfbpTnfqUVk6iN@ulmo> (Thierry Reding's message of "Thu, 10 Dec
        2020 18:48:30 +0100")
Message-ID: <875z4x5ygp.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Thierry, Trent and Robin, thanks for reviewing this and for your
comments. I think I understand a lot better now how this code needs to
work.

Trent Piepho <tpiepho@gmail.com> writes:
> Anyway, from the existing code, it seems clear that pc->pclk needs to
> be enabled for register access and pc->clk to generate a signal.  The
> call to clk_prepare(pc->pclk) should become
> clk_prepare_enable(pc->pclk) and moved to before the enabled_conf
> check.  Then clk_disable(pc->pclk) afterward.

I'll follow up with a revised set of patches that implement this. (I've
split it into multiple changes as they seem logically distinct and I
find the progression easier to see this way.)

-- 
Simon South
simon@simonsouth.net
