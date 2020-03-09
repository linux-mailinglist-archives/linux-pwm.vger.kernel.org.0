Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4E17E8C7
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 20:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgCITlt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 15:41:49 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47591 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgCITlt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 15:41:49 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Mar 2020 12:41:48 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 09 Mar 2020 12:41:48 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 420C74A19; Mon,  9 Mar 2020 12:41:48 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:41:48 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RESEND v6 1/2] pwm: Convert drivers to use 64-bit period and
 duty cycle
Message-ID: <20200309194148.GA30211@codeaurora.org>
References: <cover.1583177501.git.gurus@codeaurora.org>
 <28090aef9900ad483cbfbe77883e5ffcd8745907.1583177501.git.gurus@codeaurora.org>
 <20200306074440.ykekwwlvnbodxkjc@pengutronix.de>
 <20200306185252.GA2758@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306185252.GA2758@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Mar 06, 2020 at 10:56:59AM -0800, Guru Das Srinagesh wrote:
> On Fri, Mar 06, 2020 at 08:44:40AM +0100, Uwe Kleine-König wrote:
> > I guess we need acks from the affected maintainers. While I think the
> > changes are fine I think you won't evade having to expand the audience
> > of your patch and (depending on feedback) maybe split this patch up
> > further.
> 
> Sure. I'll split up this patch into one per file and add the respective
> maintainers for ease of reviewing.

I used the get_maintainer.pl script to add the respective maintainers of
the files. Could you please provide feedback on whether v7 what you had
in mind in your comment above?

Thank you.

Guru Das.
