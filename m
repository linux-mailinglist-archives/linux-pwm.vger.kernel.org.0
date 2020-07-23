Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3460E22B500
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 19:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGWRiq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 13:38:46 -0400
Received: from a27-45.smtp-out.us-west-2.amazonses.com ([54.240.27.45]:36964
        "EHLO a27-45.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgGWRiq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 13:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1595525925;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:To:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=l8P2fxtNJ9gcVWw2zroBuo/qlFgKHQoMyT4YPZuXDMs=;
        b=fzvVc19NdzGojKEEJIRNH5aBgJOgIich6WeFBOhRunoTCGrfSfXkDvjw4uSEc8R2
        qQdf9QFAtrKa405uLdBN40WwI43LTZ3CkkhDas7zmJ8DOXnLFpdCeurfIlsA+EEOxJA
        089br/PcIcNj7oImGpzrQRltcVJtFImIsj71kLWY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1595525925;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:To:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=l8P2fxtNJ9gcVWw2zroBuo/qlFgKHQoMyT4YPZuXDMs=;
        b=hVPZ5AB6ivWu/gvE8QC+NqnlG6P3qLND9N+QQuCpqEFQ9Rq6XzVFprLOv89DlylX
        1A8u4SeJ8Gzgs3We1vFrH4HcxRZ1SCXHyI4ER/+UC1XX4nEgLhs+ET4JC/JregrsdxX
        kbaTR3PmH+pYhmKGEExUjZGQ/8izygHP91qBnFM0=
Subject: Re: [Kernel.org Helpdesk #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "Konstantin Ryabitsev via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20200723173841.4geg4blngc2fwp4z@chatter.i7.local>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
 <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
 <rt-4.4.0-1686-1594286826-1167.89942-6-0@linuxfoundation>
 <010101734f397f00-39d54a81-d06d-4947-b9fc-332e9f9b46d5-000000@us-west-2.amazonses.com> <20200723172702.nirnet6tbmwuwd57@pengutronix.de> <010101737cb6d988-bb70d517-bbf8-44b0-aa3d-4f9eed9101f3-000000@us-west-2.amazonses.com> <20200723173841.4geg4blngc2fwp4z@chatter.i7.local>
Message-ID: <010101737cc18b4b-3c78b41c-309e-4d62-b6af-fd0536291eab-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: konstantin@linuxfoundation.org
To:     u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Thu, 23 Jul 2020 17:38:45 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.07.23-54.240.27.45
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 23, 2020 at 05:27:04PM +0000, Uwe Kleine-König via RT wrote:
> > I'm sorry, apparently I screwed up and didn't assign this ticket to
> > anyone when it came in. I was dutifully ignoring follow-ups, as I'd
> > assumed someone else would be responding.
> > 
> > Chris, I've properly assigned it to you now -- can you please
> > prioritise this request, as time allows?
> 
> Last week I thought this is a no-brainer now and will be done in a few
> hours. It seems I was wrong :-|

I do appreciate your patience. There is a lot of other work happening at 
the IT team, so your request for adding a mailing list archive has to 
contend for staff resources with many other ongoing projects.

-K

