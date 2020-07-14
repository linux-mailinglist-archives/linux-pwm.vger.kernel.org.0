Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D799220004
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGNV1Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jul 2020 17:27:16 -0400
Received: from a27-45.smtp-out.us-west-2.amazonses.com ([54.240.27.45]:36168
        "EHLO a27-45.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbgGNV1Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2020 17:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1594762035;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:To:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=78wnh39WTeijl1Hk4SN2ww2oV4omuLmuk+Vl5JtdFNY=;
        b=MxfXdvS1sgcyfgMA70vO5p1LA6EQ8W1jdtSn9LcrtM4l4z5GGh/aEf9dRCm6iS+F
        QQWjXU/SzGN13TK5qUdOQYnBrgspYBaUPr41cf61kVpZtejE2VMWXKNkA6ARJuAgg0Q
        EpvOmDcEvx0Hj8qkAl0NL6w/jQ/SAc886hyj8FW0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1594762035;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:To:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=78wnh39WTeijl1Hk4SN2ww2oV4omuLmuk+Vl5JtdFNY=;
        b=NgOUYfRrjrMlIchiJaRFPbgZLKDrcMPCjs2mWPY4bnYy2MNZaVElaDaROjN7QaU6
        jn15merCi4TALmBcpE/D1Ozd8IPlxJ1KiINWKCioMYISrta6JNXI7qTg7NJxgstK2p2
        M/UsKnbL2odIskBCWo9DoJxewW2D/jGd1rZwCYFc=
Subject: [Kernel.org Helpdesk #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "Konstantin Ryabitsev via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <rt-4.4.0-1686-1594286826-1167.89942-6-0@linuxfoundation>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
 <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
 <rt-4.4.0-1686-1594286826-1167.89942-6-0@linuxfoundation>
Message-ID: <010101734f397f00-39d54a81-d06d-4947-b9fc-332e9f9b46d5-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: konstantin@linuxfoundation.org
To:     u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Tue, 14 Jul 2020 21:27:14 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.07.14-54.240.27.45
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-07-09 05:27:06, u.kleine-koenig@pengutronix.de wrote:
> Hello Konstantin(?),

I'm sorry, apparently I screwed up and didn't assign this ticket to anyone when it came in. I was dutifully ignoring follow-ups, as I'd assumed someone else would be responding.

Chris, I've properly assigned it to you now -- can you please prioritise this request, as time allows?

Sorry again!

-K
