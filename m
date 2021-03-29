Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AECD34D531
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 18:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhC2QeI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhC2Qd7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 12:33:59 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48AC061574;
        Mon, 29 Mar 2021 09:33:59 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id BC3F8C72850;
        Mon, 29 Mar 2021 18:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617035638;
        bh=Xn3IzZFIpw6xK5uOfcTm61FzAKQLeGT60T6kbXvT9go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ch9a6bgZPtQEXlrWuSed3DDKfqbmzuoRNNTrv8nU6/BOhfwepWVTp4CGYhTo9POR6
         pSUjNYuDydHqIGTq2pXthYuhkm4NbH8Qua9hAGBqCq/AXbIgWa2ejTWeqVueYn5pUP
         aFvRBtD0B6MlrmFinbfP+mgJh7WHNdebi5SnX9LQ=
Date:   Mon, 29 Mar 2021 18:33:56 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YGIBdBdQJOgbPMTw@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-2-clemens.gruber@pqgruber.com>
 <20210329155140.4gjtsw2qbpylv77z@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329155140.4gjtsw2qbpylv77z@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 29, 2021 at 05:51:40PM +0200, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Mon, Mar 29, 2021 at 02:57:02PM +0200, Clemens Gruber wrote:
> > The hardware readout may return slightly different values than those
> > that were set in apply due to the limited range of possible prescale and
> > counter register values.
> 
> This is fine and for most hardware that's not preventable. My
> requirement here is that 
> 
> 	.get_state(pwm, &state);
> 	.apply_state(pwm, &state);
> 
> doesn't yield any changes.

Yes, that would not change anything.

Thanks,
Clemens
